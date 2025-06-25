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
}