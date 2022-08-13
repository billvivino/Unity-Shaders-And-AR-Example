using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomSpawner : MonoBehaviour
{
    [SerializeField]
    public GameObject _object;
    [SerializeField]
    public GameObject _lambertObject;

    public void InstantiateRandom()
    {
        var position = new Vector3(Random.Range(-100, 100), 150, Random.Range(-100, 100));
        var rotation = Random.rotation;
        var objectOrVariant = Random.Range(0, 2);
        print(objectOrVariant);
        if(objectOrVariant < 0.5)
        {
            GameObject.Instantiate(_object, position, rotation);
        } else
        {
            GameObject.Instantiate(_lambertObject, position, rotation);
        }
        
        
    }

    IEnumerator IntervalInstantiate(float interval, float amount)
    {
        for(int i = 0; i < amount; i++)
        {
            yield return new WaitForSeconds(interval);
            InstantiateRandom();
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(IntervalInstantiate(1.0f, 1000));
    }

    // Update is called once per frame
    void Update()
    {

    }
}
