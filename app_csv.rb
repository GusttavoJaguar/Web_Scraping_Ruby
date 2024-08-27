require 'nokogiri'
require 'net/http'
require 'csv'

https = Net::HTTP.new('br.investing.com', 443)
https.use_ssl = true

response = https.get('/')
doc = Nokogiri::HTML(response.body)

# Abre ou cria o arquivo 'bolsa.csv' para gravação ('wb') e escreve o cabeçalho (opcional).
CSV.open('bolsa.csv', 'wb') do |csv|
  # Escreve um cabeçalho opcional, se necessário
  csv << ['Último', 'Máxima', 'Mínima', 'Variação', 'Var. %', 'Vol.', 'Hora']  # Ajuste as colunas conforme necessário

  doc.search('tbody tr').each do |tr|
    # Extrai o conteúdo de cada coluna ('td') dentro de uma linha ('tr')
    columns = tr.search('td').map { |td| td.text.strip }

    # Grava as colunas no arquivo CSV
    csv << columns unless columns.empty?
  end
end
