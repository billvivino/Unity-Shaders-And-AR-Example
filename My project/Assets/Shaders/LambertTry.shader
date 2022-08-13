// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: commented out 'float4x4 _Object2World', a built-in variable
// Upgrade NOTE: commented out 'float4x4 _World2Object', a built-in variable

Shader "Unlit/LambertTry"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            Tags { "LightMode" = "ForwardBase" }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            //uniform float4 _Color;
            uniform float4 _LightColor0;
            // float4x4 _Object2World;
            // float4x4 _World2Object;
            // float4x4 _WorldSpaceLightPos0;

            // make fog work
            #pragma multi_compile_fog
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"

            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal: NORMAL;
                //float2 uv : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct vertexOutput
            {
                //float2 uv : TEXCOORD0;
                //UNITY_FOG_COORDS(1)
                float4 pos : SV_POSITION;
                float4 col: COLOR;
                UNITY_VERTEX_INPUT_INSTANCE_ID // use this to access instanced properties in the fragment shader.
            };

            UNITY_INSTANCING_BUFFER_START(Props)
                UNITY_DEFINE_INSTANCED_PROP(float4, _Color)
            UNITY_INSTANCING_BUFFER_END(Props)

            vertexOutput vert(vertexInput v){
                vertexOutput o;

                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_ACCESS_INSTANCED_PROP(Props, _Color);

                float3 normalDirection = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject).xyz);
                float3 lightDirection;
                float atten = 1.0;

                lightDirection = normalize(_WorldSpaceLightPos0.xyz);

                //float3 diffuseReflection = atten * _LightColor0.xyz * _Color.rgb * max( 0.0, dot(normalDirection, lightDirection) );
                float3 diffuseReflection = atten * _LightColor0.xyz * UNITY_ACCESS_INSTANCED_PROP(Props, _Color).rgb * max( 0.0, dot(normalDirection, lightDirection) );
                o.col = float4(diffuseReflection, 1.0);
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            float4 frag(vertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID(i);
                //return UNITY_ACCESS_INSTANCED_PROP(Props, _Color);
                return i.col;
            }

            ENDCG
        }
    }
}
