class User {
  String usr;
  String msg;

  float usrLength;
  float msgLength;

  color usrColor;
  color msgColor;

  int fontSize;

  float posx;
  float posy;

  User(String usr, String msg, int fontSize) {
    this.usr = usr;
    this.msg = msg;

    this.fontSize = fontSize;

    usrLength = textWidth(usr);
    msgLength = textWidth(msg);

    usrColor = color(155, 150, 0);
    msgColor = color(220);
  }

  void setPos(float px, float py) {
    this.posx = px;
    this.posy = py;
  }

  void setUserColor(color col) {
    this.usrColor = col;
  }

  void setMsgColor(color col) {
    this.msgColor = col;
  }

  void draw(float x, float y) {
    fill(usrColor);
    text(usr, x, y, usrLength, fontSize*2);
    fill(msgColor);
    text(msg, x + usrLength + 5, y, 33*fontSize, fontSize*4);
  }
}

