Shader "NiksShaders/Shader57Lit"
{
    Properties {
      _MainTex ("Texture", 2D) = "white" {}
      _LevelCount("Level Count", Float) = 4
    }

    SubShader {
      
    Tags { "RenderType" = "Opaque" }
      
    CGPROGRAM
      
    //#pragma surface surf SimpleLambert
    #pragma surface surf Ramp
    
    float _LevelCount;
    struct Input {
          float2 uv_MainTex;
    };
    // LightingXXXX <-- SimpleLambert function is called
    half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten) {
        half NdotL = max(0, dot(s.Normal, lightDir));
        half4 c;
        c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
        c.a = s.Alpha;
        return c;
    }

    half4 LightingRamp(SurfaceOutput s, half3 lightDir, half atten) {
        half NdotL = max(0, dot(s.Normal, lightDir));
        half3 ramp = floor(NdotL * _LevelCount) / _LevelCount;
        half4 c;
        c.rgb = s.Albedo * _LightColor0.rgb * (ramp * atten);
        c.a = s.Alpha;
        return c;
    }



      sampler2D _MainTex;
      
      void surf (Input IN, inout SurfaceOutput o) {
          o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
      }
      
      ENDCG
    } 

    Fallback "Diffuse"
}
