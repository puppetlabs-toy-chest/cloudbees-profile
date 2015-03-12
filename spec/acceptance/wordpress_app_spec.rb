require 'spec_helper_acceptance'

describe 'profile::wordpress::monolithic' do
  it 'should apply' do
    pp = <<-EOS
      class { 'profile::wordpress::monolithic': }
    EOS

    apply_manifest(pp, :catch_failures => true)
  end

  describe 'wordpress application' do
    it 'should respond with 200' do
      http = Net::HTTP.new( fact('fqdn'), 80)
      response = http.request(Net::HTTP::Get.new(uri.request_uri))
    
      expect response.code.to eq(200)
    end
  end
end
