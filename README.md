382-Lab-2
=========

Objectives
----------
Practice coding with subroutines using both pass-by-value and pass-by-reference arguements to create a message decoder.

Preliminary design
------------------
The preliminary design with pseudocode can be found [here](https://raw.githubusercontent.com/SeanGavan/382-Lab-2/master/images/flowchart.png).

Code
----
The code for this lab is located [here](https://raw.githubusercontent.com/SeanGavan/382-Lab-2/master/code/Decrypt.asm).

Debugging
---------
R6 holds mext RAM location, R5 holds current location. 0x0000 being written into R5. Fix: inc.w r6 when moving pointer instead of mov.b @r6+,r5.  
Jumps to forever when it should loop back to the subroutines. Fix: Added 0x00 catch to end the program; jeq 0x00,r7 (the message pointer) and then a jmp subs (subroutines loop) added.  
Key's address being used instead of the key itself. Fix: Stored key into R9, then used @r9+, r10 to get the actual key instead of address.


Results
-------
Test: Required Functionality  
Result: Congratulations!..You.decrypted.the.ECE382.hidden.message.and.achieved.required.functionality#  
Inputted the Required Functionality message into myMessage, and then used the memory browser to observe what was being written into RAM.

Observations and Conclusions
----------------------------
Subroutines are very convenient, more organized ways of making jumps. They keep the code from being filled with jump instructions and having labels all over the place.

Documentation
-------------
None.
