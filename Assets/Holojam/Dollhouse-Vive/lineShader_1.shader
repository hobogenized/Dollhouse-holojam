Shader "Custom/lineShader_v2" {
Properties {
	_MainTex ("Particle Texture", 2D) = "white" {}
	_Detail ("Detail", 2D) = "gray" {}
	_Color ("Main Color", COLOR) = (1,1,1,1)
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha OneMinusSrcAlpha
	Cull Off Lighting Off ZWrite Off Fog { Color (0, 0, 0, 0) }
	
	BindChannels {
		Bind "Color", color
		Bind "Vertex", vertex
		Bind "TexCoord", texcoord
	}
	
	SubShader {
		Pass {
			SetTexture [_MainTex] {
				combine texture * Constant ConstantColor[_Color] 
			}
			SetTexture [_Detail] {
                combine texture * previous
            }
//			SetTexture [_MainTex] {
//				constantColor (1,1,1,1)
//				combine previous lerp (previous) constant
//			}
		}
	}
}
}
//
//SubShader { 
//Pass{ SetTexture[_MainTex] {
//Combine texture * constant ConstantColor[_Color]
//} 
//} }



////Shader "Example/Detail" {
//	Properties {
//		_MainTex ("Texture", 2D) = "white" {}
//		_Detail ("Detail", 2D) = "gray" {}
//		_Color ("Main Color", COLOR) = (1,1,1,1)
//	}
//	SubShader {
//		Tags {"RenderType"="Opaque"}
//		LOD 100
//		CGPROGRAM
//		#pragma surface surf Lambert
//		struct Input {
//			float2 uv_MainTex;
//			float2 uv_Detail;
//		};
//		sampler2D _MainTex;
//		sampler2D _Detail;
//		float4 _Color;
//		void surf (Input IN, inout SurfaceOutput o) {
////			o.Alpha = tex2D (_MainTex, IN.uv_MainTex).a * tex2D (_Detail, IN.uv_Detail).a;
//			clip( (tex2D (_MainTex, IN.uv_MainTex).a * tex2D (_Detail, IN.uv_Detail).a)-.5);
//			o.Emission = tex2D (_MainTex, IN.uv_MainTex).rgb*_Color;//tex2D (_MainTex, IN.uv_MainTex).rgb;
//		}
//			ENDCG
//	} 
//	Fallback "Diffuse"
//}
//
//// Unlit alpha-blended shader.
//// - no lighting
//// - no lightmap support
//// - no per-material color
//
//Shader "Custom/lineShader_v2" {
//Properties {
//		_MainTex ("Texture", 2D) = "white" {}
//		_Detail ("Detail", 2D) = "gray" {}
//		_Color ("Main Color", COLOR) = (1,1,1,1)
//}
//
//SubShader {
//	Tags {"RenderType"="Opaque"}
//	LOD 100
//	
//	ZWrite Off
//		
//	Pass {  
//		CGPROGRAM
//			#pragma vertex vert
//			#pragma fragment frag
//			#pragma multi_compile_fog
//			
//			#include "UnityCG.cginc"
//
//			struct appdata_t {
//				float4 vertex : POSITION;
//				float2 texcoord : TEXCOORD0;
//			};
//
//			struct v2f {
//				float4 vertex : SV_POSITION;
//				half2 texcoord : TEXCOORD0;
//				UNITY_FOG_COORDS(1)
//			};
//
//			sampler2D _MainTex;
//			float4 _MainTex_ST;
//			sampler2D _Detail;
//			float4 _Color;
//			
//			v2f vert (appdata_t v)
//			{
//				v2f o;
//				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
//				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
//				UNITY_TRANSFER_FOG(o,o.vertex);
//				return o;
//			}
//			
//			fixed4 frag (v2f i) : SV_Target
//			{
//				fixed4 col = tex2D(_MainTex, i.texcoord);
//				UNITY_APPLY_FOG(i.fogCoord, col);
//				return col;
//			}
//		ENDCG
//	}
//}
//
//}

