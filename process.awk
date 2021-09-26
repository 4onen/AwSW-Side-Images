#!/bin/awk -f
/^c /{
    CHAR=$2
    RECT=$3
    SCALE=$4
    TF=0
    CONT=0
    print "#",CHAR,RECT,SCALE
}
/^cf /{
    CHAR=$2
    RECT=$3
    SCALE=$4
    TF=1
    CONT=0
    print "# flip",CHAR,RECT,SCALE
}
/^cuf /{
    CHAR=$2
    RECT=$3
    SCALE=$4
    TF=2
    CONT=0
    print "# unflipped",CHAR,RECT,SCALE
}
/^cc /{
    CHAR=$2
    RECT=$3
    SCALE=$4
    TF=0
    CONT=1
    print "# CONT: ",CHAR,RECT,SCALE
}
/^ccf /{
    CHAR=$2
    RECT=$3
    SCALE=$4
    TF=1
    CONT=1
    print "# CONT: flip",CHAR,RECT,SCALE
}
/^ccbf /{
    CHAR=$2
    RECT=$3
    SCALE=$4
    TF=3
    CONT=1
    print "# CONT: bugged flip",CHAR,RECT,SCALE
}
/^f /{
    print substr($0,3)
    CHAR=""
}
/^\/\//{
    printf "#%s\n",substr($0,3)
}
/^\$ /{
    printf "%s\n",substr($0,3)
}
!/^(c |cf |cuf |cc |ccf |ccbf |\/\/|f |\$ )/{
    if (length($0) < 2 && length(CHAR) > 0 && CONT==0){
        printf("image side %s = 'side %s normal'\n",CHAR,CHAR)
        CHAR=""
    }else if(length($0) > 2){
        EMOT=$0
        EMOTUL=EMOT
        gsub(/ /,"_",EMOTUL)
        if(TF==0){
            printf("image side %s %s = im.Flip(im.Scale(im.Crop(\"cr/%s_%s.png\",%s),%s),horizontal=True)\n",CHAR,EMOT,CHAR,EMOTUL,RECT,SCALE)
        }else if(TF==1){
            printf("image side %s %s = im.Scale(im.Crop(\"cr/%s_%s_flip.png\",%s),%s)\n",CHAR,EMOT,CHAR,EMOTUL,RECT,SCALE)
        }else if(TF==2){
            printf("image side %s %s = im.Scale(im.Crop(\"cr/%s_%s.png\",%s),%s)\n",CHAR,EMOT,CHAR,EMOTUL,RECT,SCALE)
        }else if(TF==3){
            printf("image side %s %s = im.Scale(im.Crop(im.Flip(\"cr/%s_%s_flip.png\",horizontal=True),%s),%s)\n",CHAR,EMOT,CHAR,EMOTUL,RECT,SCALE)
        }
    }
}
END {
    if (length(CHAR) > 0 && CONT==0){
        printf("image side %s = 'side %s normal'\n",CHAR,CHAR)
    }
}