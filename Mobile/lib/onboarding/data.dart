class SliderModel {
  String? imagePath;
  String? title;
  String? description;
  SliderModel({this.imagePath, this.title, this.description});

  void setImgPath(String getImagePath) {
    imagePath = getImagePath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDescription(String getDescription) {
    description = getDescription;
  }

  String getImagePath() {
    return imagePath!;
  }

  String getTitle() {
    return title!;
  }

  String getDescription() {
    return description!;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = <SliderModel>[];
  SliderModel initialsliders = SliderModel();
  //1st screen
  initialsliders.setImgPath("assets/appinit/01appinit.png");
  initialsliders.setDescription(
      "You will get our support as always.");
  initialsliders.setTitle("Do You feel Depressed now?");
  slides.add(initialsliders);

  initialsliders = SliderModel();
  //2nd screen
  initialsliders.setImgPath("assets/appinit/02appinit.png");
  initialsliders.setDescription(
      "With regular taking pills you will recover soon and safe from side-effects from not taking pills regularly.");
  initialsliders.setTitle("Health Improvement");
  slides.add(initialsliders);

  initialsliders = SliderModel();
  //3rd  screen
  initialsliders.setImgPath("assets/appinit/03appinit.png");
  initialsliders.setDescription(
      "Get notified for every pill , that too with catchy sound");
  initialsliders.setTitle("Get Notification's");
  slides.add(initialsliders);

  initialsliders = SliderModel();
  return slides;
}
