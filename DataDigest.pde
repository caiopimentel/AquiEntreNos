class DataDigest {
  String [] rawData;
  String [] [] countryData; 
  //countryData: [n][0] = Nome pais; [n][1] = distancia proxima; [n][2] = distancia conhecido; [n][3] = distancia desconhecido

  public DataDigest () {
  }


  public void loadData (String fileName_)
  { //carrega e preprocessa dados de distancia dos countries
    rawData = loadStrings (fileName_);
    countryData = new String[rawData.length][4]; 

    for (int i = 1; i < rawData.length; i++) {
      countryData [i] = split (rawData[i], ',');
    }
  }


  private String [] findMatches (float distance_, int relation_) 
  {
    float offset = 3.5;
    float distance = distance_;
    float distanceOffsetMax = distance + offset;
    float distanceOffsetMin = distance - offset;
    int relation = relation_; // Espera receber valores entre 1 e 3. Para 1 proximos; 2 conhecidos; 3 desconhecidos
    String [] countries = new String [0];

    for (int i = 1; i < rawData.length; i++) 
    { //Checa dentro da relacao de proximidade dada pelo relation quais paises se encaixam no intervalo de distancia
      if ((float(countryData[i][relation]) >= distanceOffsetMin) && (float (countryData[i][relation]) <= distanceOffsetMax)) {
        countries = append (countries, countryData[i][0]);
      }
    }

    return countries;
  }


  public String getCountry (float distance_, int relation_) 
  {
    String [] countries = findMatches (distance_, relation_);
    String sortedCountry;

    if (countries.length > 0) {
      sortedCountry = countries [int(random(0, countries.length))];
    } else {
      sortedCountry = ""; //Se nao houver pais correspondente
    }

    return sortedCountry;
  }
}

