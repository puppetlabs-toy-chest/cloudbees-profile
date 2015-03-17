require 'spec_helper_acceptance'

describe 'profile::wordpress::integrated' do
  it 'should apply' do
    pp = <<-EOS
      class { 'profile::wordpress::integrated':
        db_user     => 'wordpress',
        db_password => 'wordpress',
      }
    EOS

    apply_manifest(pp, :catch_failures => true)
  end

  it 'should start nginx service' do
    expect( shell('service nginx status').exit_code).to eq(0)
  end
end

describe 'wordpress application' do
  it 'should respond with 302 redirect to web based installer' do
    ip = fact('ipaddress')
    url = "http://#{ip}"

    uri = URI.parse(url)
    http = Net::HTTP.new( uri.host, uri.port)
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
  
    expect(response.code).to eq("302")
    expect(response['location']).to eq("#{url}/wp-admin/install.php")
  end
end
