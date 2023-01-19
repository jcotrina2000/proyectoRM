String diaEspaniolFormateado(String diaIngles){
    switch(diaIngles){
      case "Sunday": return "D";
      case "Saturday":return "S";
      case "Monday":return "L"; 
      case "Tuesday":return "M"; 
      case "Wednesday":return "M"; 
      case "Thursday":return "J"; 
      case "Friday":return "V"; 
      case "Saturday":return "S"; 
      default : return "D"; 
    }
  }