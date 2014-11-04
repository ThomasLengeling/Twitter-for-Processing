import twitter4j.conf.*;
import twitter4j.api.*;
import twitter4j.*;

import java.util.List;
import java.util.Iterator;

ConfigurationBuilder   cb;
Query query;
Twitter twitter;

ArrayList<String> twittersList;
Timer             time;

String strTrend;
int    trendId = 1; //worldWide

PFont font;
int   fontSize = 14;

void setup() {
  size(670, 450);
  background(0);
  smooth(4);

  //FONT
  font = createFont("NexaLight-16.vlw", fontSize, true);
  textFont(font, fontSize);

  //You can only search once every 1 minute
  time = new Timer(70000); //1 min with 10 secs

  //Acreditacion
  cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("");
  cb.setOAuthConsumerSecret("");
  cb.setOAuthAccessToken("");
  cb.setOAuthAccessTokenSecret("");

  //Make the twitter object and prepare the query
  twitter = new TwitterFactory(cb.build()).getInstance();

  //SEARCH
  twittersList = queryTwitter();
}

void draw() {
  background(50);

  //draw twitters

  fill(255);
  textFont(font, fontSize*1.5);
  text(strTrend, 30, 40);
  
  drawTwitters(twittersList);

  if (time.isDone()) {
    twittersList = queryTwitter();
    time.reset();
  }

  text(time.getCurrentTime(), width - 70, 40);

  time.update();
}

void drawTwitters(ArrayList<String> tw) {
  Iterator<String> it = tw.iterator();
  int i = 0;
  
  textFont(font, fontSize);
  while (it.hasNext ()) {
    String twitt = it.next();
    fill(150);
    text(i + 1, 57, 80 + i*(fontSize)*2.2 + fontSize);
    fill(220);
    text(twitt, 80, 80 + i*(fontSize)*2.2, 600, fontSize*2.7);
    i++;
  }
}

ArrayList<String> queryTwitter() {
  ArrayList<String> twitt = new ArrayList<String>();
  try {

    Trends trends = twitter.getPlaceTrends(trendId);
    for (int i = 0; i < trends.getTrends().length; i++) {
      println(trends.getTrends()[i].getName());
      twitt.add(trends.getTrends()[i].getName());
    }

    strTrend = "World Wide Trend Topic id: "+trendId;
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  }

  return twitt;
}

