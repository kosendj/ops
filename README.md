# Kosendj Ops

## Credentials

root へ Google アカウントを共有してください。利用目的に応じて IAM アカウントおよびパスワードなどが通知されます。

## Cap Tasks

### IAM

```
cap iam dry-run
cap iam apply
```

### Route 53

```
cap r53 dry-run
cap r53 apply
```

## Itamae

```
$ cd itamae/
$ bundle exec hocho apply --dry-run akeno
$ bundle exec hocho apply akeno
```


## Infrataster

```
$ bundle exec rspec --color -fd -I infrataster infrataster
```

## Misc

### easy-rsa for OpenVPN

Root CA is managed outside of git. Ask @sorah for details

## People

### root

- @sorah
