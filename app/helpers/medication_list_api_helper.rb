module MedicationListApiHelper
  require "net/http"
  
  def med_query_one
    query = params[:med_one]
    if query.present? 
      url = URI("https://rxnav.nlm.nih.gov/REST/drugs.json?name=#{query}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      req = Net::HTTP::Get.new(url)

      response = JSON.parse(http.request(req).body)

      response["drugGroup"]["conceptGroup"].map { |drug| @med_option_one = drug["conceptProperties"] }
    end
  end

  # def med_query_two
  #   query = params[:med_two]
  #   if query.present? 
  #     url = URI("https://rxnav.nlm.nih.gov/REST/drugs.json?name=#{query}")

  #     http = Net::HTTP.new(url.host, url.port)
  #     http.use_ssl = true
  #     req = Net::HTTP::Get.new(url)

  #     response = JSON.parse(http.request(req).body)

  #     response["drugGroup"]["conceptGroup"].map { |drug| @med_option_two = drug["conceptProperties"] }
  #   end
  # end
end
