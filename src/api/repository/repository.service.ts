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
  // postgresql e psql_bouncer usam o adapter do Postgres.
  // O driver adapter (pg) ignora o parâmetro `?schema=` da URI — recurso que só
  // existia no conector nativo do Prisma. Extraímos o schema e:
  //   1. passamos via opção `schema` (qualifica as queries geradas pelo Prisma);
  //   2. definimos o `search_path` na conexão pg, para que as queries `$queryRaw`
  //      (que referenciam tabelas sem prefixo, ex.: `FROM "Message"`) também
  //      resolvam no schema correto.
  let schema: string | undefined;
  try {
    schema = new URL(connectionString).searchParams.get('schema') ?? undefined;
  } catch {
    schema = undefined;
  }
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
