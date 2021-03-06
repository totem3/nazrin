module Nazrin
  class DocumentClient
    attr_reader :client

    def initialize
      @client = Aws::CloudSearchDomain::Client.new(
        endpoint: Nazrin.config.document_endpoint,
        region: Nazrin.config.region,
        access_key_id: Nazrin.config.access_key_id,
        secret_access_key: Nazrin.config.secret_access_key)
    end

    def add_document(id, field_data)
      ActiveSupport::Deprecation.warn 'config.debug_mode is deprecated. Use config.mode = \'sandbox\' instead.' and return nil if Nazrin.config.debug_mode
      return nil if Nazrin.config.mode == 'sandbox'
      client.upload_documents(
        documents: [
          {
            type: 'add',
            id: id,
            fields: field_data
          }
        ].to_json,
        content_type: 'application/json')
    end

    def delete_document(id)
      ActiveSupport::Deprecation.warn 'config.debug_mode is deprecated. Use config.mode = \'sandbox\' instead.' and return nil if Nazrin.config.debug_mode
      return nil if Nazrin.config.mode == 'sandbox'
      client.upload_documents(
        documents: [
          {
            type: 'delete',
            id: id
          }
        ].to_json,
        content_type: 'application/json')
    end
  end
end
