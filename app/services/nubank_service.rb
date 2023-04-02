class NubankService
  def self.connect_process
    last_processed_transaction = Config.last.last_processed_transaction
    api_nubank_uri = 'https://ctis-api-lrzbakfyzq-uc.a.run.app'
    uri = URI("#{api_nubank_uri}/process_all_transactions?last_processed_transaction=#{last_processed_transaction}")
    JSON.parse(Net::HTTP.get(uri))
  end

  def self.connect_qrcode(qrcode)
    api_nubank_uri = 'https://ctis-api-lrzbakfyzq-uc.a.run.app/generate_payment_qrcode'
    headers = { 'Content-Type' => 'application/json' }
    response = HTTParty.post(api_nubank_uri, headers:, body: qrcode.to_json)
    JSON.parse(response.body)
  end
end
