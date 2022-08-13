using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

namespace PnTTechnicalInterviewTest
{
    public struct DeviceMotionEvent
    {
        public Vector3 Acceleration { get; set; }
        public Vector3 AccelerationIncludingGravity { get; set; }
    }

    public class TrackCameraOrientation : MonoBehaviour
    {
        public UnityEvent<DeviceMotionEvent> DeviceMotionChange;

        private Vector3 LastPosition;

        void Update() {
            // simulate a shaky cam - as if a user is holding a device

            var newPosition = Vector3.Lerp( transform.position, transform.position + Random.insideUnitSphere, Time.deltaTime * 0.2f );

            var rotationOffset = Quaternion.AngleAxis( (Random.value * 2f - 1f) * 10f, Vector3.up ) *
                Quaternion.AngleAxis( ( Random.value * 2f - 1f ) * 10, Vector3.right );
            var newRotation = Quaternion.Lerp( transform.rotation, transform.rotation * rotationOffset, Time.deltaTime * 0.2f );

            transform.SetPositionAndRotation( newPosition, newRotation );

            // calculate the motion and fire the event

            var delta = transform.position - LastPosition;
            if ( delta != Vector3.zero ) {
                var motion = new DeviceMotionEvent {
                    Acceleration = delta / Time.deltaTime,
                    AccelerationIncludingGravity = (delta + Physics.gravity) / Time.deltaTime
                };

                DeviceMotionChange.Invoke( motion );
            }

            LastPosition = transform.position;
        }
    }
}
