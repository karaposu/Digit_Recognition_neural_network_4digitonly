# Digit_Recognition_neural_network_4digitonly

Enes Kuzucu 

This code trains a Neural Network to identify digits (Digits are drawed from Microsoft Paint and only  1, 2, 3, 4 are accepted) 

First version of the project was not working efficiently because of the number of the data sample required to train NN needs to be bigger that small numebrs such as 30 . So I found MNIST hand drawn dataset with 10.000 examples for each digit. I used this dataset to train my Neural Network.

But results were not good. Reason for that was MNIST dataset created from  real handwritten images and the characteristic of that data is seriously different from images created USİNG Paint.. That is why it failed. 

Shivang Srivastava (Programmer who tries to code a simular application) says "The thickness of the image is too thin which does not match our training data. As the MNSIT dataset consists of atleast 45% of the character in the entire image." Which is very different from samples drawed by Paint Software.

After this realisation I created 200 pictures from Paint and write a code to add them to MNIST dataset accordingly.
For MNIST dataset and my dataset to be balanced in samples I  did not used all of the examples in MNIST.
jpg format used
In the end results showed created NN had a 75% true recognition  .

