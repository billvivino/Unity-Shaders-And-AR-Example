using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RemoveIfOffScreen : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (gameObject.transform.position.y < -200) {
            Destroy(gameObject);
        }
    }
}
