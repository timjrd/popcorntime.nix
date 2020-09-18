{ fetchFromGitHub }: rec {
  pname = "popcorntime";
  version = "be800aa9";
  src = fetchFromGitHub {
    owner = "popcorn-official";
    repo = "popcorn-desktop";
    rev = version;
    sha256 = "05wpm6hvxza85lcfgwzi0alfmc2gnhz8fs8jsdvbnv5lyys53vw7";
  };
}
