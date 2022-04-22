# Markdown to slides

**This is work in progress**

This is a draft of a  Mojolicious application that converts markdown files into slides. The markdown files are in 'public/md/', and the meda for each slide in '/public/*presentation_number*'. There is a symlink in 'public/md/' to the media directory for for the markdown file to be able to find the media. 

You can see examples of the:
* [Markdown File](https://github.com/mimosinnet/presentation/blob/master/public/md/01/Presentacio.md)
* [Slides Outline](https://github.com/mimosinnet/presentation/ScreenShots/Outline.png)
* [Slides](https://github.com/mimosinnet/presentation/ScreenShots/Slide.png)

While seeing slides, click on the slide to go to the next slide and move the mouse at the top of the slide to see the list of slides.

The example shows the first presentation and it does not include all the presentations (size). The database needs to be created in the data folder, with the following chema: 

```sqlite

sqlite> .schema
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "diapositiva" (
    "id" INTEGER PRIMARY KEY NOT NULL,
    "numero" INTEGER NOT NULL,
    "html_code" BLOB NOT NULL,
    "presentacio" INTEGER NOT NULL,
    FOREIGN KEY("presentacio") REFERENCES "presentacio"("id")
);
CREATE TABLE IF NOT EXISTS "cursos" (
	"id" INTEGER PRIMARY KEY NOT NULL,
	"Curs" TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS "presentacio" (
    "id" INTEGER PRIMARY KEY NOT NULL,
    "Curs_id" INTEGER NOT NULL DEFAULT 1,
    "Presentacio" TEXT NOT NULL,
    "Diapositives" INTEGER NOT NULL,
    FOREIGN KEY("Curs_id") REFERENCES "cursos"("id")
);
