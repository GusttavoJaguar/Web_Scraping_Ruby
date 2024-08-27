require 'nokogiri'
require 'net/http'

https = Net::HTTP.new('br.investing.com', 443)
https.use_ssl = true

response = https.get('/')
doc = Nokogiri::HTML(response.body)

# Abre o arquivo em modo de adição ('a') para que novas linhas sejam adicionadas ao invés de sobrescrever o arquivo.
File.open('bolsa.txt', 'a') do |file|
  doc.search('tbody tr').each do |tr|
    # Salva o conteúdo da linha no arquivo.
    file.puts tr.text.strip
  end
end
