import { ConfigService, Database } from '@config/env.config';
import { Logger } from '@config/logger.config';
import { PrismaMariaDb } from '@prisma/adapter-mariadb';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '@prisma/client';

export class Query<T> {
  where?: T;
  sort?: 'asc' | 'desc';
  page?: number;
  offset?: number;
}

// Prisma 7 exige driver adapter. Seleciona o adapter conforme DATABASE_PROVIDER.
function createPrismaAdapter(connectionString: string) {
  const provider = process.env.DATABASE_PROVIDER ?? 'postgresql';
  if (provider === 'mysql') {
    return new PrismaMariaDb(connectionString);
  }
  // The Prisma 7 pg driver adapter does NOT honor the `?schema=` param in the URL
  // (that is a Prisma-engine param, not a libpq one). Without it, queries default to
  // the `public` schema and fail with P2021 for tables in a named schema (e.g.
  // evolution_api). We extract the schema and:
  //   1. pass `{ schema }` so Prisma-generated queries are qualified;
  //   2. set the pg connection `search_path` so raw `$queryRaw` queries (which
  //      reference tables without a schema prefix, e.g. `FROM "Message"` in
  //      fetchChats) also resolve in the correct schema.
  let schema: string | undefined;
  try {
    schema = new URL(connectionString).searchParams.get('schema') ?? undefined;
  } catch {
    const schemaMatch = connectionString.match(/[?&]schema=([^&]+)/);
    schema = schemaMatch ? decodeURIComponent(schemaMatch[1]) : undefined;
  }

  // postgresql e psql_bouncer usam o adapter do Postgres
  if (!schema) {
    return new PrismaPg(connectionString);
  }
  return new PrismaPg({ connectionString, options: `-c search_path=${schema}` }, { schema });
}

export class PrismaRepository extends PrismaClient {
  constructor(private readonly configService: ConfigService) {
    super({ adapter: createPrismaAdapter(configService.get<Database>('DATABASE').CONNECTION.URI) });
  }

  private readonly logger = new Logger('PrismaRepository');

  public async onModuleInit() {
    await this.$connect();
    this.logger.info('Repository:Prisma - ON');
  }

  public async onModuleDestroy() {
    await this.$disconnect();
    this.logger.warn('Repository:Prisma - OFF');
  }
}
