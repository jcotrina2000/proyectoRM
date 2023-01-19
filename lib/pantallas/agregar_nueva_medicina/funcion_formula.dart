int numeroVecesMedicina(int horas){
  int horasDia = 24;
    switch(horas){
      case 1: return horasDia ~/ 1;
      case 2:return horasDia ~/ 2;
      case 3:return horasDia ~/ 3; 
      case 4:return horasDia ~/ 4; 
      case 5:return horasDia ~/ 5; 
      case 6:return horasDia ~/ 6; 
      case 7:return horasDia ~/ 7; 
      case 8:return horasDia ~/ 8; 
      case 9:return horasDia ~/ 9; 
      case 10:return horasDia ~/ 10; 
      case 11:return horasDia ~/ 11; 
      case 12:return horasDia ~/ 12; 
      case 13:
      case 14:
      case 15:
      case 16:
        return 2; 
      case 17:
      case 18:
      case 19:
      case 20:
      case 21:
      case 22:
      case 23:
      case 24:
        return horasDia ~/ 24; 
      default : return horasDia ~/ 24; 
    }
  }