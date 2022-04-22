# Markdown to slides

**This is work in progress**

This is a draft of a  Mojolicious application that converts markdown files into slides. The markdown files are in 'public/md/', and the meda for each slide in '/public/*presentation_number*'. There is a symlink in 'public/md/' to the media directory for for the markdown file to be able to find the media. 

You can see examples of the:
* [Markdown File](http://presentacions.mimosinnet.org/show_markdown/01)
* [Slides Outline](http://presentacions.mimosinnet.org/diapos/01)
* [Slides](http://presentacions.mimosinnet.org/presenta/01/1)
* [Slides using Remark](http://127.0.0.1:3000/remark/01#1)

While seeing slides, click on the slide to go to the next slide and move the mouse at the top of the slide to see the list of slides.

The media is not included in github (size), neither the configuration file (security). In this case, the content of the configuration file (*presentacions.conf*) is:

```Perl
{
  hypnotoad => {
    proxy => 1,
    pid_file => '/tmp/hypnotoad_presentacions.pid',
    listen => ['http://*:8086']
  },
	secrets => [
		'secret',
		'secret', 
		'secret'
	],
};
```
