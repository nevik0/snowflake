_: {
  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "zh_CN.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.utf8";
      LC_IDENTIFICATION = "zh_CN.utf8";
      LC_MEASUREMENT = "zh_CN.utf8";
      LC_MONETARY = "zh_CN.utf8";
      LC_NAME = "zh_CN.utf8";
      LC_NUMERIC = "zh_CN.utf8";
      LC_PAPER = "zh_CN.utf8";
      LC_TELEPHONE = "zh_CN.utf8";
      LC_TIME = "zh_CN.utf8";
    };
  };

  console.keyMap = "us";
  services.xserver.xkb.layout = "us";
}