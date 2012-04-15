#!/usr/bin/perl

use strict;
use warnings;
no  warnings 'uninitialized';

use Test::More tests => 15;
use Here::Template;

my $out;


$out = <<"TMPL";
foo
TMPL

is $out, <<'END', "heredoc";
foo
END


$out = <<"TMPL";
<?= $$ ?>
TMPL

is $out, <<"END", "single var";
$$
END


$out = <<"TMPL";
<?= $$ ?><?= $$ ?>
TMPL

is $out, <<"END", "two vars side-by-side";
${$}$$
END


$out = <<"TMPL";
<? $here .= $$ ?>
TMPL

is $out, <<"END", "single statement";
$$
END


$out = <<"TMPL";
<? $here .= $$ ?><? $here .= $$ ?>
TMPL

is $out, <<"END", "two statements side-by-side";
${$}$$
END


$out = <<"TMPL";
<?= $$ ?>
<?= $$ ?>
TMPL

is $out, <<"END", "two vars in two lines";
$$
$$
END


$out = <<"TMPL";
<? $here .= $$ ?>
<? $here .= $$ ?>
TMPL

is $out, <<"END", "two statements in two lines";
$$
$$
END


$out = <<"TMPL";
foo <?= $$ ?> bar
TMPL

is $out, <<"END", "var in the middle";
foo $$ bar
END


$out = <<"TMPL";
foo <? $here .= $$ ?> bar
TMPL

is $out, <<"END", "statement in the middle";
foo $$ bar
END


$out = <<"TMPL";
<?= 
    $$ 
?>
TMPL

is $out, <<"END", "multiline var";
$$
END


$out = <<"TMPL";
<?
    $here .= $$ 
?>
TMPL

is $out, <<"END", "multiline statement";
$$
END


$out = <<"TMPL";
<?
    $here .= $$ 
?><?
    $here .= $$
?>
TMPL

is $out, <<"END", "two multiline statements";
${$}$$
END


$out = <<"TMPL";
<? for (1..2) { ?>$_
<? } ?>
TMPL

is $out, <<"END", "loop with default variable in heredoc";
1
2

END


$out = <<"TMPL";
foo
bar
<? for (1..2) { ?>$_
<? } ?>
TMPL

is $out, <<"END", "loop with default variable in heredoc at the end";
foo
bar
1
2

END


$out = <<"TMPL";
<? for (1..2) { ?>$_
<? } ?>
foo
bar
TMPL

is $out, <<"END", "loop with default variable in heredoc at the beginning";
1
2

foo
bar
END



