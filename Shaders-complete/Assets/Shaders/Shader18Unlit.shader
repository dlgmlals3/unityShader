﻿Shader "NiksShaders/Shader18Unlit"
{
    Properties
    {
        _Color("Color", Color) = (1.0,1.0,1.0,1.0)
        _LineWidth("Line Width", Float) = 0.02
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
// Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct v2f members position)
#pragma exclude_renderers d3d11
            #pragma vertex vert
            #pragma fragment frag

            #define PI2 6.28318530718


            #include "UnityCG.cginc"

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 position: TEXCOORD1;
                float2 uv: TEXCOORD0;
            };
            
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.position = v.vertex;
                o.uv = v.texcoord;
                return o;
            }
           
            fixed4 _Color;
            float _LineWidth;
            
            float getDelta(float x){
                return (sin(x)+1.0)/2.0;
            }

            float onLine(float x, float y, float line_width, float edge_width){
                return smoothstep(x-line_width/2.0-edge_width, x-line_width/2.0, y) - smoothstep(x+line_width/2.0, x+line_width/2.0+edge_width, y);
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                float2 pos = i.position.xy * 2.0;
                fixed3 color = _Color * onLine(i.uv.y, lerp(0.2, 0.8, getDelta(pos.x*PI2)), _LineWidth, _LineWidth*0.2);
                fixed3 axisColor = fixed3(0.5, 0.5, 0.5);
                color += onLine(i.uv.x, 0.5, 0.002, 0.002)*axisColor;
                color += onLine(i.uv.y, 0.5, 0.002, 0.001)*axisColor;
                
                return fixed4(color, 1.0);
            }
            ENDCG
        }
    }
}
