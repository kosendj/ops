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

## Bootstrapping physical servers

enable sshd then:

```
$ scp bootstrap/${target_hostname}.sh dj@${target}:bootstrap.sh
$ ssh dj@${target}
remote $ sudo bash bootstrap.sh

```

## People

### root

- @sorah
