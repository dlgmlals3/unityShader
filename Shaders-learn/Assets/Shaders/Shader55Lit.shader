Shader "NiksShaders/Shader55Lit"
{
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _BumpMap ("Bumpmap", 2D) = "bump" {}
      _Cube ("Cubemap", CUBE) = "" {}
    }

    SubShader {
      
      Tags { "RenderType" = "Opaque" }
      
      CGPROGRAM
      
      #pragma surface surf Lambert
      
      struct Input {
          float2 uv_MainTex;
          float2 uv_BumpMap;
          float3 worldRefl;
          INTERNAL_DATA
      };
      
      sampler2D _MainTex;
      samplerCUBE _Cube;
      sampler2D _BumpMap;
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * 0.5;
          o.Emission = texCUBE (_Cube, WorldReflectionVector(IN, o.Normal)).rgb;
          o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}
