+++
title = "My PGP"
description = "This page describes how to retrieve and verify my PGP public key"
date = "2024-10-21"
+++

I primarily use <abbr title="Pretty Good Privacy">PGP</abbr> so others can verify the authenticity of the software I distribute. All source tarballs, Git tags and releases created by me after 21 Oct, 2024, have been signed with this key. You can also use this key to securely encrypt any sensitive emails you send to me.

## Key Information

- **Key Type**: RSA, 4096 bits (PGPv4)
- **Primary User ID**: Eray Aydın (<erayaydinn@protonmail.com>)
- **Key Fingerprint**: `B746 4249 5027 825F 59B5 2120 1ADC AE73 2A0F C5A8`
- **Additional UIDs**:
  - Eray Aydın (<erayaydin2016@gmail.com>)
  - Eray Aydın (<er@yayd.in>)
- **Key Expiration**: January 28, 2026

## Retrieving My Key

You can obtain my public key using one of the following methods:

### From a Public Key Server

You can fetch my public key from a public key server using this command:

```sh
gpg --keyserver hkp://keyserver.ubuntu.com --recv-key 0xB74642495027825F59B521201ADCAE732A0FC5A8
```

### Direct Download from This Site

Alternatively, you can [download](/B74642495027825F59B521201ADCAE732A0FC5A8.pub.asc) my public key directly from this site and import it into GPG manually:

```sh
gpg --import B74642495027825F59B521201ADCAE732A0FC5A8.pub.asc
```

## Using My Key

Once you've retrieved and verified my PGP key, you can use it to check the integrity of software I’ve signed or communicate securely.

### Verifying a Tarball

To verify a tarball, download both the tarball and the signature file, and place them in the same directory. Run:

```sh
gpg --verify <signature_file>.sig <tarball>
```

Check the output to ensure the signature is valid and was made with my key.

### Verify a Git Tag

To verify a signed Git tag, use the following command:

```sh
git tag -v <tag>
```

Verify that the signature is reported as valid and corresponds to my key.

