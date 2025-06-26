class Note{
     
      String name;
      String desc;

    Note({required this.name,required this.desc});

    static toMap(Note note){
      return{
        "name":note.name,
        "desc":note.desc
      };
    }

    factory Note.fromMap(Map<String,dynamic> map){
      return Note(name: map["name"], desc:map["desc"] );
    }
}