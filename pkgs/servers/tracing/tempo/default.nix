{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "tempo";
  version = "2.4.0";

  src = fetchFromGitHub {
    owner = "grafana";
    repo = "tempo";
    rev = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-ory7UllnV6Qzjvk2dy5B9pell0Ezse2NAn2rQ1gDsGM=";
  };

  vendorHash = null;

  subPackages = [
    "cmd/tempo-cli"
    "cmd/tempo-query"
    "cmd/tempo-serverless"
    "cmd/tempo-vulture"
    "cmd/tempo"
  ];

  ldflags = [
    "-s"
    "-w"
    "-X=main.Version=${version}"
    "-X=main.Branch=<release>"
    "-X=main.Revision=${version}"
  ];

  # tests use docker
  doCheck = false;

  meta = with lib; {
    description = "A high volume, minimal dependency trace storage";
    license = licenses.asl20;
    homepage = "https://grafana.com/oss/tempo/";
    maintainers = with maintainers; [ willibutz ];
  };
}
