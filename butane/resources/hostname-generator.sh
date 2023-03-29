#!/usr/bin/bash
adjectiv=(abrupt adorable amiable amused average brave broad charming cheerful clean clear cloudy cruel curved dangerous dull eager elegant flat foolish fresh friendly gentle healthy helpful helpless high ideal jumpy kind nervous petty plain pleasant precious salty sarcastic silky timely tricky weary)
animal=(cow dog dolphin donkey eagle fish fly fox frog gerbil goose gopher gorilla heron horse ibis iguana impala jackal jaguar javanese jellyfish kakapo kangaroo penguin kiwi koala lemming lemur leopard saola scorpion snake swan tuatara turkey zebra antelope baboon bear)

random_adjectiv=$(( $RANDOM % 41 ))
random_animal=$(( $RANDOM % 41 ))

if [ -f /etc/hostname ]; then
    exit 0
else
    echo  "${adjectiv[$random_adjectiv]}-${animal[$random_animal]}" > /etc/hostname 
fi
