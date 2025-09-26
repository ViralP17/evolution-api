import { PrismaRepository } from '@api/repository/repository.service';
import { ConfigService, Database, licenseurl } from '@config/env.config';
import { BadRequestException } from '@exceptions';
import axios from 'axios';
import https from 'https';

export class AuthService {
  constructor(
    private readonly prismaRepository: PrismaRepository,
    private readonly configService: ConfigService,
  ) {}

  public async checkDuplicateToken(token: string) {
    if (!token) {
      return true;
    }

    const instances = await this.prismaRepository.instance.findMany({
      where: { token },
    });

    if (instances.length > 0) {
      throw new BadRequestException('Token already exists');
    }

    return true;
  }
  public async checkLicenseKey(licenceKey: string) {
    try {
      const instance = axios.create({
        httpsAgent: new https.Agent({
          rejectUnauthorized: false,
          timeout: 5000,
        }),
      });
      const env = this.configService.get<licenseurl>('LICENSEURL');

      const response = await instance.post(`${env}?license_key=${licenceKey}`);
      console.log({ response });

      if (response.data.message != 'Valid' || !licenceKey) return false;
      return { LicType: response.data.type, scanAllowed: response.data.scanallowed };
    } catch (e) {
      console.log({ e });

      return false;
    }
  }
  public async isAllowedMoreScan(licenceKey: string, scanAllowed: string) {
    try {
      const db = this.configService.get<Database>('DATABASE');
      console.log({ db });
      const docs = await this.prismaRepository.instance.findMany({
        where: { LicenseKey: licenceKey, connectionStatus: 'open' },
      });

      if (docs.length && docs.length >= Number(scanAllowed)) {
        return false;
      }
      return true;
    } catch (e) {
      console.log({ e });
      return false;
    }
  }
}
