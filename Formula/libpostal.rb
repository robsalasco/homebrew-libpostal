class Libpostal < Formula
  desc "C library for parsing/normalizing street addresses around the world using NLP and open geo data"
  homepage "https://github.com/openvenues/libpostal"
  url "https://github.com/openvenues/libpostal/archive/refs/tags/v1.1.tar.gz"
  sha256 "8cc473a05126895f183f2578ca234428d8b58ab6fadf550deaacd3bd0ae46032"
  head "https://github.com/openvenues/libpostal.git"

  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build

  def install
    system "./bootstrap.sh"

    if !Hardware::CPU.arm?
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{prefix}",
                            "--datadir=#{share}/libpostal-data"
    else
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--disable-sse2",
                            "--prefix=#{prefix}",
                            "--datadir=#{share}/libpostal-data"
    end
    
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <stdlib.h>
      #include <libpostal/libpostal.h>
      
      int main(int argc, char **argv) {
          // Setup (only called once at the beginning of your program)
          if (!libpostal_setup() || !libpostal_setup_parser()) {
              exit(EXIT_FAILURE);
          }
      
          libpostal_address_parser_options_t options = libpostal_get_address_parser_default_options();
          libpostal_address_parser_response_t *parsed = libpostal_parse_address("781 Franklin Ave Crown Heights Brooklyn NYC NY 11216 USA", options);
      
          for (size_t i = 0; i < parsed->num_components; i++) {
              printf("%s: %s\\n", parsed->labels[i], parsed->components[i]);
          }
      
          // Free parse result
          libpostal_address_parser_response_destroy(parsed);
      
          // Teardown (only called once at the end of your program)
          libpostal_teardown();
          libpostal_teardown_parser();
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}",
                             "-lpostal", "-o", "test"
    system "./test"
  end
end
