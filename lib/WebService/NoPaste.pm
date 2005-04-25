package WebService::NoPaste;
use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request::Common 'POST';
our $VERSION = '0.01';

sub process {
    my %args = %_;
    my $host = delete $args{host} || 'http://rafb.net';
    my $post_path = delete $args{post_path} || '/paste/paste.php';
    print "Paste at will...\n";
    my %data = (%args, text => join('', <STDIN>));
    my $r = LWP::UserAgent->new->request(POST $host . $post_path, [%data]);
    die "Didn't get a '302 Found'.  WebService::NoPaste was designed for paste CGI's that redirect on success, so maybe you're using a different kind (let me know if this is the case - rking\@panoptic.com).  Or, maybe there was an error.  Here's the response: \n" . $r->as_string
        unless 302 == $r->code;
    my $payload_path = $r->headers->header('Location');
    $payload_path =~ s/\.html$// or die "That's strange ($payload_path)";
    print "Paste successfully posted to:\n";
    print "$host$payload_path.$_\n" for 'txt', 'html';
}

1;
=head1 NAME 

WebService::NoPaste - Post to Paste Web Pages

=head1 SYNOPSIS

    # Interactively paste:
    $ nopaste

    # Instantly upload your passwd file for the whole world to see:
    $ nopaste < /etc/passwd 

    Note: I am deliberating what the best args would be (currently it
    takes none).  If during your use you find it annoying that you don't
    have the ability to quickly change options from the command-line,
    your feedback would be appreciated.

    (If you'd like to use the internal perl interface, just look at
    C<nopaste>.  It would probably need rearranging to fit other needs,
    so please let me know if you have plans.)

=head1 DESCRIPTION

    When online chatting it is problematic to paste an entire 300 line
    file.  Yes paste?  No.  NoPaste!

    Posting to a paste host is preferred.  These servers are just web
    forms that accept input from a big text field, and temporarily house
    them as web pages.

    This script/module is for those who find it tedious to switch to a
    web browser, load the page, and then paste.  Why use the mouse when
    you can use the keyboard? ;)

    Note: It has only been tested against one kind of CGI, so email me
    if doesn't work on your favorite server.

=head1 CONFIGURATION
    
    Currently, you just edit "nopaste" itself to point it at a different
    server, to change languages (which only affects the way the HTML
    formatting syntax highlights), etc.

    This is lame, I know.  But it's version 0.01.  If you'd like neater
    configuration, email me, and I'll get right to it.

=head1 AUTHOR

Ryan King <rking@panoptic.com>

=head1 COPYRIGHT

Copyright (c) 2005. Ryan King. All rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
# vi:tw=72
