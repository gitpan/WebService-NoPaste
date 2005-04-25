use inc::Module::Install;
name('WebService-NoPaste');
author('Ryan King <rking@panoptic.com');
abstract('WebService-NoPaste - Poste to Paste Web Pages');
license('perl');
version_from('lib/WebService/NoPaste.pm');
requires(qw(
    HTTP::Request::Common 0
    LWP::UserAgent 0
));
install_script('nopaste');
check_nmake();
&WriteAll();
