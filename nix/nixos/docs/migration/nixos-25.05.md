2025-05-26 bumped nixos and home-manager to 25.05

# Errors and Warnings
```
       last 25 log lines:
       > xh_ZA.UTF-8/UTF-8 \
       > xh_ZA/ISO-8859-1 \
       > yi_US.UTF-8/UTF-8 \
       > yi_US/CP1255 \
       > yo_NG/UTF-8 \
       > yue_HK/UTF-8 \
       > yuw_PG/UTF-8 \
       > zgh_MA/UTF-8 \
       > zh_CN.GB18030/GB18030 \
       > zh_CN.GBK/GBK \
       > zh_CN.UTF-8/UTF-8 \
       > zh_CN/GB2312 \
       > zh_HK.UTF-8/UTF-8 \
       > zh_HK/BIG5-HKSCS \
       > zh_SG.GBK/GBK \
       > zh_SG.UTF-8/UTF-8 \
       > zh_SG/GB2312 \
       > zh_TW.EUC-TW/EUC-TW \
       > zh_TW.UTF-8/UTF-8 \
       > zh_TW/BIG5 \
       > zu_ZA.UTF-8/UTF-8 \
       > zu_ZA/ISO-8859-1 \
       > Error: unsupported locales detected:
       > en_US.utf8/UTF-8 \
       > You should choose from the list above the error.
       For full logs, run 'nix log /nix/store/zkxf1v8hnhcnwhyzzp2yyxn3vp2073zj-glibc-locales-2.40-66.drv'.
[
```

ran `$ nix log /nix/store/zkxf1v8hnhcnwhyzzp2yyxn3vp2073zj-glibc-locales-2.40-66.drv` to see the nix logs

I saw 'en_US.UTF-8/UTF-8 \' in the output.

try updating
```nix
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
``
to
```nix
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
```

