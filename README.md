382-Lab-2
=========

Objectives
----------
Practice coding with subroutines using both pass-by-value and pass-by-reference arguements to create a message decoder.

Preliminary design
------------------
The preliminary design with pseudocode can be found in the provided flowchart (flowchart.png) in the images folder.

Code
----
The code for this lab is located under the code folder.

Debugging
---------
R6 holds mext RAM location, R5 holds current location. 0x0000 being written into R5. Fix: inc.w r6 when moving pointer instead of mov.b @r6+,r5.  
Jumps to forever when it should loop back to the subroutines. Fix: Added 0x00 catch to end the program; jeq 0x00,r7 (the message pointer) and then a jmp subs (subroutines loop) added.  


Results
-------
Test: Required Functionality  
Result: Congratulations!..You.decrypted.the.ECE382.hidden.message.and.achieved.required.functionality#

Observations and Conclusions
----------------------------


Documentation
-------------
None.
