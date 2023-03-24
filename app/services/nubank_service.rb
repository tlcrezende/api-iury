require 'uri'
require 'net/http'
require 'json'

class NubankService
  def self.process
    # uri = URI('https://ctis-api-lrzbakfyzq-uc.a.run.app/process_all_transactions?last_processed_transaction=641c5a31-8ccf-4ced-89ff-753a031084e7')
    # response = Net::HTTP.get(uri)
    # p response
    response = '{"processed_transactions":[{"aluno_pagamento_id":1,"status":"efetuado","data_pagamento":"2023-03-24T00:00:00+00:00","transaction_id":"641d3c9b-2a80-453e-b7f1-18dbbf68d768"},{"aluno_pagamento_id":1,"status":"efetuado","data_pagamento":"2023-03-24T00:00:00+00:00","transaction_id":"641d3be0-4281-4f26-ac6a-7d0297f0a6c5"}],"last_processed_transaction":"641d3c9b-2a80-453e-b7f1-18dbbf68d768"}'
  end
end
