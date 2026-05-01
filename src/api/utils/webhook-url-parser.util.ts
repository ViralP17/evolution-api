import { Logger } from '@config/logger.config';

/**
 * Utility to extract userid and dbname from webhook URL parameters
 * For migrating from Webhook to SQS without modifying instance names
 * 
 * Old webhook URL: https://scalladev.scallacrm.co.il/modules/CTWhatsApp/CTWhatAppReceiver.php?userid=1&dbname=prefix_ykkgz290523063702
 * New SQS message extracts: userid=1, dbname=prefix_ykkgz290523063702
 */
export class WebhookUrlParserUtil {
  private static readonly logger = new Logger('WebhookUrlParserUtil');

  /**
   * Parse webhook URL to extract userid and dbname parameters
   * @param webhookUrl - Full webhook URL with query parameters
   * @returns Object with userid and dbname if found, empty object otherwise
   */
  public static extractParamsFromUrl(webhookUrl: string | undefined): Record<string, any> {
    const params: Record<string, any> = {};

    if (!webhookUrl) {
      return params;
    }

    try {
      // Parse URL to extract query parameters
      const url = new URL(webhookUrl);
      const searchParams = url.searchParams;

      // Extract userid parameter
      const userid = searchParams.get('userid');
      if (userid) {
        params.userid = userid;
      }

      // Extract dbname parameter
      const dbname = searchParams.get('dbname');
      if (dbname) {
        params.dbname = dbname;
      }

      // Extract any other custom parameters that might be useful
      const prefix = searchParams.get('prefix');
      if (prefix) {
        params.prefix = prefix;
      }

      return params;
    } catch (error) {
      this.logger.warn({
        message: 'Failed to parse webhook URL',
        webhookUrl,
        error: error instanceof Error ? error.message : 'Unknown error',
      });
      return params;
    }
  }

  /**
   * Extract parameters from multiple webhook URLs (backward compatibility)
   * @param webhookUrl - Primary webhook URL
   * @param webhookByEventsUrls - Optional map of event-specific URLs
   * @returns Combined parameters (primary URL takes precedence)
   */
  public static extractParamsFromMultipleUrls(
    webhookUrl: string | undefined,
    webhookByEventsUrls?: Record<string, string>,
  ): Record<string, any> {
    const params: Record<string, any> = {};

    // First try to get from by-events URLs
    if (webhookByEventsUrls && typeof webhookByEventsUrls === 'object') {
      for (const eventUrl of Object.values(webhookByEventsUrls)) {
        if (typeof eventUrl === 'string') {
          const eventParams = this.extractParamsFromUrl(eventUrl);
          // Merge, but don't overwrite if already found
          if (eventParams.userid && !params.userid) params.userid = eventParams.userid;
          if (eventParams.dbname && !params.dbname) params.dbname = eventParams.dbname;
        }
      }
    }

    // Then get from primary URL (takes precedence)
    const primaryParams = this.extractParamsFromUrl(webhookUrl);
    return {
      ...params,
      ...primaryParams,
    };
  }

  /**
   * Format extracted parameters for SQS message
   * @param webhookUrl - Webhook URL to parse
   * @returns Extra parameters object ready for SQS
   */
  public static formatForSqs(webhookUrl: string | undefined): Record<string, any> {
    return this.extractParamsFromUrl(webhookUrl);
  }

  /**
   * Check if webhook URL contains userid and/or dbname
   * @param webhookUrl - Webhook URL to check
   * @returns Boolean indicating if URL has extractable parameters
   */
  public static hasExtractableParams(webhookUrl: string | undefined): boolean {
    if (!webhookUrl) return false;

    try {
      const url = new URL(webhookUrl);
      const hasUserid = url.searchParams.has('userid');
      const hasDbname = url.searchParams.has('dbname');
      return hasUserid || hasDbname;
    } catch {
      return false;
    }
  }

  /**
   * Log extraction details for debugging
   * @param webhookUrl - Webhook URL
   */
  public static logExtractionDetails(webhookUrl: string | undefined): void {
    if (!webhookUrl) {
      this.logger.debug('No webhook URL provided for extraction');
      return;
    }

    const params = this.extractParamsFromUrl(webhookUrl);
    const hasParams = Object.keys(params).length > 0;

    this.logger.debug({
      message: 'Webhook URL extraction details',
      webhookUrl,
      hasParams,
      extractedParams: Object.keys(params),
    });
  }
}
