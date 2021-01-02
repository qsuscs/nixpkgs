{ stdenv
, fetchurl
, lzip
, texinfo
, pkgconfig
, pandoc
, gettext
, libiconv
, zlib
, lzma
, bzip2
, brotli
, zstd
, gnutls
, libidn2
, libpsl
, nghttp2
, libmicrohttpd
, gpgme
, pcre2
}:

stdenv.mkDerivation rec {
  pname = "wget2";
  version = "1.99.2";
  src = fetchurl {
    url = "mirror://gnu/wget/wget2-${version}.tar.lz";
    sha256 = "0k1w0j9bdijy3psc2q3a5w6mgn1vl8zaqmicfzylkiwym32x2pgc";
  };

  doCheck = true;
  enableParallelBuilding = true;

  nativeBuildInputs = [ lzip texinfo pkgconfig pandoc libiconv ];

  buildInputs = [ libiconv zlib lzma bzip2 brotli zstd gnutls libidn2 libpsl nghttp2 gpgme pcre2 ]
                ++ stdenv.lib.optionals doCheck [ libmicrohttpd ];

  postInstall = ''
    rm $out/bin/wget2_noinstall
  '';

  meta = with stdenv.lib; {
    description = "A file and recursive website downloader";
    longDescription = ''
      GNU Wget2 is the successor of GNU Wget, a file and recursive website downloader.
      Designed and written from scratch it wraps around libwget, that provides the basic functions needed by a web client.
      Wget2 works multi-threaded and uses many features to allow fast operation.
      In many cases Wget2 downloads much faster than Wget1.x due to HTTP2, HTTP compression, parallel connections and use of If-Modified-Since HTTP header.
    '';
    homepage = "https://www.gnu.org/software/wget/";
    license = licenses.gpl3Plus;
    platforms = platforms.all;
  };
}
