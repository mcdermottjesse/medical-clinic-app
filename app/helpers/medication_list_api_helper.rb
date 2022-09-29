module MedicationListApiHelper
  require "net/http"
  
  def med_query
    query = @medication_param
    if query.present? 
      url = URI("https://rxnav.nlm.nih.gov/REST/drugs.json?name=#{query}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      req = Net::HTTP::Get.new(url)

      response = JSON.parse(http.request(req).body)

      response["drugGroup"]["conceptGroup"].map { |drug| @med_options = drug["conceptProperties"] }
    end
  end
end
