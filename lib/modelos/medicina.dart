class Medicina {
  int? id;
  String? nombre;
  String? cantidad;
  String? unidad;
  int? semanas;
  String? cadaNHoras;
  String? formaMedicina;
  int? tiempo;
  int? notiId;

  Medicina({
    this.id,
    this.semanas,
    this.cadaNHoras,
    this.tiempo,
    this.cantidad,
    this.formaMedicina,
    this.nombre,
    this.unidad,
    this.notiId});

  /*Convertir la medicina en mapa(diccionario)*/ 
  Map<String, dynamic> medicinaToMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this.id;
    map['nombre'] = this.nombre;
    map['cantidad'] = this.cantidad;
    map['unidad'] = this.unidad;
    map['semanas'] = this.semanas;
    map['cadaNHoras'] = this.cadaNHoras;
    map['formaMedicina'] = this.formaMedicina;
    map['tiempo'] = this.tiempo;
    map['notiId'] = this.notiId;
    return map;
  }
  /*Crear objeto medicina con el mapa*/
  Medicina medicinaMapToObject(Map<String, dynamic> mapaMedicina) {
    return Medicina(
        id: mapaMedicina['id'],
        nombre: mapaMedicina['nombre'],
        cantidad: mapaMedicina['cantidad'],
        unidad: mapaMedicina['unidad'],
        semanas: mapaMedicina['semanas'],
        cadaNHoras: mapaMedicina['cadaNHoras'],
        formaMedicina: mapaMedicina['formaMedicina'],
        tiempo: mapaMedicina['tiempo'],
        notiId: mapaMedicina['notiId']);
  } 
  /*Recursos - ruta imágenes*/
  String get image{
    switch(this.formaMedicina){
      case "Jarabe": return "assets/images/jarabe.png";
      case "Pildora":return "assets/images/pildora.png";
      case "Jeringuilla":return "assets/images/jeringuilla.png"; 
      case "Tableta":return "assets/images/tableta.png"; 
      default : return "assets/images/pildora.png"; 
    }
  }
}