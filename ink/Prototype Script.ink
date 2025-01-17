/* 
PROLOGUE SCRIPT for PROTOYPE - 1/15/25

In the meantime, without knowing whether or not this is a good way of organizing text into the game, here's how this works:

CX_ = Circle Number
intro_ = any "cutscene" for the incoming circle
level_ = any text during the fruit stand gameplay, including specific characters
market = any text during the farmer's market, including specific vendors

Some comments will be included to talk about how certain text may be integrated into the game
*/

-> C0_prologue

=== C0_prologue

= intro

// ideally, this would just be shown visually without text
Midway along the journey of life, Danny Pilgrim ran a fruit stand.
Peaceful and unassuming...
Until the ground opened up below and swallowed them up.
Danny Pilgrim woke to find themselves in a dark wood...
With nothing but their fruit stand...
And a leopard staring at them, hungry.
It lept forward, straight at Danny Pilgrim!
It sunk its teeth into flesh...
Of a red, juicy apple. 
The leopard was pleased.
It called up its friends, and now there were a bunch of beasts staring at Danny Pilgrim and his unassuming fruit stand.

    -> level_virgil

= level_virgil

// Virgil likely shows up at the end of the level, with no other customers present
Oh greetings! 
What a nice fruit stand you have there...
You must be the destined traveler, called upon by Lucifer.
Oh, Lucifer?
Don't you know?
The ruler of Hell has requested an exquisite drink from the fruits of humanity.
I, Virgil, shall be your guide through Hell, all the way to Lucifer's chambers, where you shall serve Him.
//Be warned though, my services aren't for free.

    -> market_virgil
    
= market_virgil

    -> market_virgil_intro

= market_virgil_intro
// Upon first interacting with Virgil's stand, which is mandatory before moving on
Oh salutations, destined traveler!
Welcome to my humble shop.
You shall have the opportunity to restock produce and fancy up your stand.
Hm?
Where are you?
Why, you're at the entrance of Hell!
We shall make make haste in our journey, and venture into the First Circle of Hell.

    -> market_virgil_default
    
= market_virgil_default
// this is currently made to appease the logic of ink, I'm not sure how exactly you can integrate these flow of choices within the game, but technically it makes logical sense here in Ink.
Welcome to my humble shop, destined traveler.
 + [Chat] -> market_virgil_chat
 + [Exit] -> market_virgil_end

= market_virgil_chat
// These are various choices the player can choose and talk about with Virgil
    + This can't be real.
        Foolishness, traveler.
        All of this is very much real.
        Ask the leopards and lions.
        They'll tear you apart if you're not careful.
        -> market_virgil_chat
    + How am I supposed to survive?
        That is a fabulous question, traveler.
        I don't know.
        ...What?
        I'm merely a guide.
        It's up to you to fend for youself.
        Hm, though I will say...
        It seems that fruit stand of yours saved you back there.
        It may save you again.
        -> market_virgil_chat
    + Who are you?
        I am Virgil.
        ...
        Oh, you wanted more?
        I am Virgil, who sells fruits and appliances.
        ...
        You don't seem satisfied by my answer.
        -> market_virgil_chat
    + [Exit] -> market_virgil_end

= market_virgil_end
// Once you are done and want to exit Virgil's stand, this mandatory text begins.
Destined traveler, I believe it would be in your best interest to invest in that fruit stand of yours.
Your arrival has been making ripples across the Circles.
Now everyone in Hell will be craving for a taste of your fruits.
Since yours had broken during your great fall, I suggest you take this trusty blender of mines.
Go ahead.

    -> market_virgil_end2

= market_virgil_end2
// The player will drag and "purchase" the blender, which will be used for gameplay in the next Circle
Perfect.
Now how will you pay for it?
Hm...?
You don't have any money? Nothing?
Oh no, I suppose then you are now indebted to me.
For my services as your guide, and for the goods you have taken from me...
Everything you earn shall be forfeited to me by the end of your journey!
But enough talk, we shall move onward!
    -> END
