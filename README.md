# 🌱 Docker Container for Seedtool

This Docker container makes it easy to run [Blockchain Commons' Seedtool CLI](https://github.com/BlockchainCommons/bc-seedtool-cli) without having to install all dependencies.

At the time of this writing (February 2021), Seedtool is considered *feature-complete and is entering beta-level testing* -- in other words, check the code and make sure the code fits your risk profile and threat model.


## Dependencies

* [`Docker`](http://docker.io/)
* [`Git`](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)


## Installation

```
git clone https://github.com/guiambros/docker-bc-seedtool-cli
cd docker-bc-seedtool-cli
./build.sh
docker run seedtool-cli seedtool --help
```

## Usage

Check [Seedtool documentation](https://github.com/BlockchainCommons/bc-seedtool-cli/blob/master/Docs/MANUAL.md) and [usage examples](https://github.com/BlockchainCommons/bc-seedtool-cli/blob/master/Docs/Usage.md) for details on how to use. 


### Convert a pre-defined seed into BIP-39 Mnemonics, using encode it using SSKR as 3 shares, 2 of which are required for recovery

```
$ HEX_PWD=`echo -n "secret password!" | od -A n -t x1| sed 's/ *//g' | tr -d '\n'`
$ docker run seedtool-cli seedtool --in hex ${HEX_PWD} --out sskr --group 3-of-5
tuna acid epic gyro lava vial able also able exam jolt girl trip roof wasp hard tomb safe main toil jazz sets numb soap iced keys join gray noon
tuna acid epic gyro lava vial able also acid tuna soap sets poem hang vial puff iced mint hill yank apex puma fund junk open brew real meow junk
tuna acid epic gyro lava vial able also also gift jump slot luau bald fern undo urge memo idle deli stub flew fair void iris iron what lamb aqua
tuna acid epic gyro lava vial able also apex omit tiny gift zone vast echo edge item silk real aunt onyx exam time high pose also door road wall
tuna acid epic gyro lava vial able also aqua acid huts iron plus fact flew jazz each ruin atom tiny skew keys tomb limp fern swan numb brew pose
```

### Recover a SSKR-encoded seed using 2 of the 3 shares

Note the order of entries doesn't matter; you just need the n shares, as you specified above:

```
$ cat << EOF | docker run -i seedtool-cli /bin/bash -c 'seedtool --in sskr' | xxd -r -p && echo
tuna acid epic gyro lava vial able also aqua acid huts iron plus fact flew jazz each ruin atom tiny skew keys tomb limp fern swan numb brew pose
tuna acid epic gyro lava vial able also acid tuna soap sets poem hang vial puff iced mint hill yank apex puma fund junk open brew real meow junk
tuna acid epic gyro lava vial able also able exam jolt girl trip roof wasp hard tomb safe main toil jazz sets numb soap iced keys join gray noon
EOF
# result: secret password!
```

### Run container interatively, so you can use seedtool normally in a sandbox environment

Of course you can also enter the container and run seedtool in a segregated environment:

```
$ docker run -ti --rm seedtool-cli /bin/bash
```
