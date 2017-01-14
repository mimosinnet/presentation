#!/usr/bin/env perl
use Mojolicious::Lite;

plugin 'RevealJS';

any '/' => { template => 'mytalk', layout => 'revealjs' };

app->start;
