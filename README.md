# Unity-Shaders-Example
The task was to create a new shader, then instantiate 1000 random game object prefabs with it, then create a screenspace UI with a button to further instantiate, then make a Lambert Shader with GPU instancing to speed it up.  Not sure if I did the last part right... any comments are appreciated!

The second task was as follows:

1. Without parenting the building object to the marker object, smoothly interpolate the position of the building object to the marker object's world position, offset by 3 units in the marker object's local positive y-axis direction.
2. Align the building rotation such that it appears to be sitting upright on top of the marker object plane.
3. Slowly rotate the building around its local positive y-axis 10 degrees/second.
Bonus Assume that this is an AR application, and you're faced with the challenge of accommodating the marker being positioned either on a poster on the wall, or laying flat on a table. In some AR technologies, there is no concept of a "world up direction" - you only have the user device's accelerometer motion expressed in m/s², which changes as the user moves their phone or tablet. Using the motion data received in the event listener in PositionBuilding.cs, orient the building object such that it always appears to be standing upright in the user's real-world space - in both flat and upright marker orientations.
