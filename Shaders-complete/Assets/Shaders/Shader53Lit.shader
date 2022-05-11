﻿Shader "NiksShaders/Shader53Lit"
{
    Properties {
        _MainTex ("Texture", 2D) = "white" {}
        _BumpMap ("Bumpmap", 2D) = "bump" {}
        _RimColor ("Rim Color", Color) = (0.26, 0.19, 0.16, 0.0)
        _RimPower ("Rim Power", Range(0.5, 8.0)) = 3.0
        _RimWidth ("Rim Width", Range(0, 1)) = 0.6
    }

    SubShader
    {

        Tags { "RenderType" = "Opaque" }

        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 viewDir;
        };

        sampler2D _MainTex;
        sampler2D _BumpMap;
        float4 _RimColor;
        float _RimPower;
        float _RimWidth;

        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
            o.Normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
            
            float rim =  max(0.0, _RimWidth - saturate(dot(o.Normal, normalize(IN.viewDir))));
            o.Emission = _RimColor.rgb * pow (rim, _RimPower);
        }
        ENDCG
    }

    Fallback "Diffuse"
}
