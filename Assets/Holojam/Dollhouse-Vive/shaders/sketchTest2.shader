Shader "Custom/sketchTest2" {

    Properties 
    {
       	_Color ("Color", Color) = (1,1,1,1)
		_DarkColor ("Sketch Color", Color) = (1,1,1,1)
		_MultColor ("Multiply Color", Color) = (1,1,1,1)
		_Tile ("Tiling", Float) = 12
		
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_CrossTex1("Sketch Darkest (RGB)", 2D) = "white" {}
		_CrossTex2("Sketch (RGB)", 2D) = "white" {}
		_CrossTex3("Sketch (RGB)", 2D) = "white" {}
		_CrossTex4("Sketch (RGB)", 2D) = "white" {}
		_CrossTex5("Sketch (RGB)", 2D) = "white" {}
		_CrossTex6("Sketch Lightest (RGB)", 2D) = "white" {}
    }
    SubShader 
    {
    
        Tags {"Queue" = "Geometry" "RenderType" = "Opaque"}
        Pass 
        {
            Tags {"LightMode" = "ForwardBase"}                      // This Pass tag is important or Unity may not give it the correct light information.
           		CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #pragma multi_compile_fwdbase                       // This line tells Unity to compile this pass for forward base.
                
                #include "UnityCG.cginc"
                #include "AutoLight.cginc"
                
               	struct vertex_input
               	{
               		float4 vertex : POSITION;
               		float3 normal : NORMAL;
               		float2 texcoord : TEXCOORD0;
               		
               		float2 uv_MainTex;
               		
               	};
                
                struct vertex_output
                {
                    float4  pos         : SV_POSITION;
                    float2  uv          : TEXCOORD0;
                    float3  lightDir    : TEXCOORD1;
                    float3  normal		: TEXCOORD2;
                    LIGHTING_COORDS(3,4)                            // Macro to send shadow & attenuation to the vertex shader.
                	float3  vertexLighting : TEXCOORD5;
                };
                
                sampler2D _MainTex;
				sampler2D _CrossTex1;
				sampler2D _CrossTex2;
				sampler2D _CrossTex3;
				sampler2D _CrossTex4;
				sampler2D _CrossTex5;
				sampler2D _CrossTex6;
				
                fixed4 _Color;
                fixed4 _LightColor0; 
                
				fixed4 _DarkColor;
				fixed4 _MultColor;
				float _Tile;
                
                vertex_output vert (vertex_input v)
                {
//                	_MultColor*=2;
                    vertex_output o;
                    o.pos = mul( UNITY_MATRIX_MVP, v.vertex);
                    o.uv = v.texcoord.xy;
//					
//					o.lightDir = ObjSpaceLightDir(v.vertex);
//					
//					o.normal = v.normal;
//                    
//                    TRANSFER_VERTEX_TO_FRAGMENT(o);                 // Macro to send shadow & attenuation to the fragment shader.
//                    
//                    o.vertexLighting = float3(0.0, 0.0, 0.0);
//		            
//		            #ifdef VERTEXLIGHT_ON
//  					
//  					float3 worldN = mul((float3x3)_Object2World, SCALED_NORMAL);
//		          	float4 worldPos = mul(_Object2World, v.vertex);
//		            
//		            for (int index = 0; index < 4; index++)
//		            {    
//		               float4 lightPosition = float4(unity_4LightPosX0[index], 
//		                  unity_4LightPosY0[index], 
//		                  unity_4LightPosZ0[index], 1.0);
//		 
//		               float3 vertexToLightSource = float3(lightPosition - worldPos);        
//		               
//		               float3 lightDirection = normalize(vertexToLightSource);
//		               
//		               float squaredDistance = dot(vertexToLightSource, vertexToLightSource);
//		               
//		               float attenuation = 1.0 / (1.0  + unity_4LightAtten0[index] * squaredDistance);
//		               
//		               float3 diffuseReflection = attenuation * float3(unity_LightColor[index]) 
//		                  * float3(_MultColor) * max(0.0, dot(worldN, lightDirection));         
//		 
//		               o.vertexLighting = o.vertexLighting + diffuseReflection * 2;
//		            }
//		                  
//		         
//		            #endif
                    
                    return o;
                }
                
                fixed4 frag(vertex_output i) : COLOR
                {
//                    _MultColor*=2;
//
//                    i.lightDir = normalize(i.lightDir);
//                    fixed atten = LIGHT_ATTENUATION(i); // Macro to get you the combined shadow & attenuation value.
//                    
                    fixed4 tex = tex2D(_MainTex, i.uv);
                    tex *= _MultColor;// + fixed4(i.vertexLighting, 1.0);
                  
//                    fixed diff = saturate(dot(i.normal, i.lightDir));
//                                        
                    fixed4 c;
//                    c.rgb = (UNITY_LIGHTMODEL_AMBIENT.rgb * 2 * tex.rgb)	 * _MultColor;         // Ambient term. Only do this in Forward Base. It only needs calculating once.
//                    c.rgb += (tex.rgb * _LightColor0.rgb * diff) * (atten * 2); // Diffuse and specular.
//                    c.a = tex.a + _LightColor0.a * atten;
                    
                  	c=tex; 
                    
                    float3 emit;
					
					float timex = 0;//_Time.x*300.333;
					float timey = 0;//_Time.x*300.333;
					float2 nUV = float2(timex+i.uv.x*_Tile,timey+i.uv.y*_Tile);

					fixed4 CR1 = tex2D (_CrossTex1, nUV);
					fixed4 CR2 = tex2D (_CrossTex2, nUV);
					fixed4 CR3 = tex2D (_CrossTex3, nUV);
					fixed4 CR4 = tex2D (_CrossTex4, nUV);
					fixed4 CR5 = tex2D (_CrossTex5, nUV);
					fixed4 CR6 = tex2D (_CrossTex6, nUV);
//					
					emit = CR1;
					
//					
//					if(c.r > .1)
//						emit = lerp(CR1.rgb,CR2.rgb,(c.r-.1)*10);
//					if(c.r > .2)
//						emit = lerp(CR2.rgb,CR3.rgb,(c.r-.2)*10);
//					if(c.r > .3)
//						emit = lerp(CR3.rgb,CR4.rgb,(c.r-.3)*10);
//					if(c.r > .4)
//						emit = lerp(CR4.rgb,CR5.rgb,(c.r-.4)*10);
//					if(c.r > .5)
//						emit = lerp(CR5.rgb,CR6.rgb,(c.r-.5)*10);
//					if(c.r > .6)
//						emit = lerp(CR6.rgb,float4(1),(c.r-.6)*10);
//					if(c.r > .7)
//						emit = float4(1);

					emit = lerp(CR1.rgb,
						   lerp(CR2.rgb,
						   lerp(CR3.rgb,
						   lerp(CR4.rgb,
						   lerp(CR5.rgb,
						   lerp(CR6.rgb, float4(1,1,1,1), 
						   		clamp((c.r-0.6)*10, 0, 1)),
						   		clamp((c.r-0.5)*10, 0, 1)),
						   		clamp((c.r-0.4)*10, 0, 1)),
						   		clamp((c.r-0.3)*10, 0, 1)),
						   		clamp((c.r-0.2)*10, 0, 1)),
						   		clamp((c.r-0.1)*10, 0, 1));
						   
//					
					emit += _DarkColor*(1-emit);
////					emit = float3(min(emit.x,_DarkColor.x),emit.y,emit.z);
					return (emit*_Color,1.0);
//					
					
//                    return c;
                }
            ENDCG
        }
// 
//        Pass {
//            Tags {"LightMode" = "ForwardAdd"}                       // Again, this pass tag is important otherwise Unity may not give the correct light information.
//            Blend One One                                           // Additively blend this pass with the previous one(s). This pass gets run once per pixel light.
//            CGPROGRAM
//                #pragma vertex vert
//                #pragma fragment frag
//                #pragma multi_compile_fwdadd                        // This line tells Unity to compile this pass for forward add, giving attenuation information for the light.
//                
//                #include "UnityCG.cginc"
//                #include "AutoLight.cginc"
//                
//                struct v2f
//                {
//                    float4  pos         : SV_POSITION;
//                    float2  uv          : TEXCOORD0;
//                    float3  lightDir    : TEXCOORD2;
//                    float3 normal		: TEXCOORD1;
//                    LIGHTING_COORDS(3,4)                            // Macro to send shadow & attenuation to the vertex shader.
//                };
// 
//                v2f vert (appdata_tan v)
//                {
//                    v2f o;
//                    
//                    o.pos = mul( UNITY_MATRIX_MVP, v.vertex);
//                    o.uv = v.texcoord.xy;
//                   	
//					o.lightDir = ObjSpaceLightDir(v.vertex);
//					
//					o.normal =  v.normal;
//                    TRANSFER_VERTEX_TO_FRAGMENT(o);                 // Macro to send shadow & attenuation to the fragment shader.
//                    return o;
//                }
// 
//                sampler2D _MainTex;
//                fixed4 _Color;
//                
//                sampler2D _CrossTex1;
//				sampler2D _CrossTex2;
//				sampler2D _CrossTex3;
//				sampler2D _CrossTex4;
//				sampler2D _CrossTex5;
//				sampler2D _CrossTex6;
//				                
//				fixed4 _DarkColor;
//				fixed4 _MultColor;
//				float _Tile;
// 
//                fixed4 _LightColor0; // Colour of the light used in this pass.
// 
//                fixed4 frag(v2f i) : COLOR
//                {
//                
//                	_MultColor*=2;
//                	
//                 	i.lightDir = normalize(i.lightDir);
//                    fixed atten = LIGHT_ATTENUATION(i); // Macro to get you the combined shadow & attenuation value.
//                    
//                    fixed4 tex = tex2D(_MainTex, i.uv);
//                    tex *= _MultColor;// + fixed4(i.vertexLighting, 1.0);
//                  
//                    fixed diff = saturate(dot(i.normal, i.lightDir));
//                                        
//                    fixed4 c;
//                    c.rgb = (UNITY_LIGHTMODEL_AMBIENT.rgb * 2 * tex.rgb) * _MultColor;         // Ambient term. Only do this in Forward Base. It only needs calculating once.
//                    c.rgb += (tex.rgb * _LightColor0.rgb * diff) * (atten * 2); // Diffuse and specular.
//                    c.a = tex.a + _LightColor0.a * atten;
//                    
//                    
//                    
//                  
//
////                    i.lightDir = normalize(i.lightDir);
////                    fixed atten = LIGHT_ATTENUATION(i); // Macro to get you the combined shadow & attenuation value.
////                    
////                    fixed4 tex = tex2D(_MainTex, i.uv);
////                    tex *= _MultColor + fixed4(i.vertexLighting, 1.0);
////                  
////                    fixed diff = saturate(dot(i.normal, i.lightDir));
////                                        
////                    fixed4 c;
////                    c.rgb = (UNITY_LIGHTMODEL_AMBIENT.rgb * 2 * tex.rgb) * _MultColor;         // Ambient term. Only do this in Forward Base. It only needs calculating once.
////                    c.rgb += (tex.rgb * _LightColor0.rgb * diff) * (atten * 2); // Diffuse and specular.
////                    c.a = tex.a + _LightColor0.a * atten;
////                    i.lightDir = normalize(i.lightDir);
////                    
////                    fixed atten = LIGHT_ATTENUATION(i); // Macro to get you the combined shadow & attenuation value.
//// 
////                    fixed4 tex = tex2D(_MainTex, i.uv);
////                    
////                    tex *= _Color;
////                   
////					  fixed3 normal = i.normal;                    
////                    fixed diff = saturate(dot(normal, i.lightDir));
////                    
////                    
////                    fixed4 c;
////                    c.rgb = (UNITY_LIGHTMODEL_AMBIENT.rgb * 2 * tex.rgb) * _MultColor;         // Ambient term. Only do this in Forward Base. It only needs calculating once.
//////                  
////					  c.rgb += (tex.rgb * _LightColor0.rgb * diff) * (atten * 2);
//////   				  c.rgb = (tex.rgb * _LightColor0.rgb * diff) * (atten * 2) * _MultColor; // Diffuse and specular.
////                    c.a = tex.a;
////                    
//                    
//                    
//                    float3 emit;
//					
//					float timex = 0;//_Time.x*300.333;
//					float timey = 0;//_Time.x*300.333;
//					float2 nUV = float2(timex+i.uv.x*_Tile,timey+i.uv.y*_Tile);
//
//					fixed4 CR1 = tex2D (_CrossTex1, nUV);
//					fixed4 CR2 = tex2D (_CrossTex2, nUV);
//					fixed4 CR3 = tex2D (_CrossTex3, nUV);
//					fixed4 CR4 = tex2D (_CrossTex4, nUV);
//					fixed4 CR5 = tex2D (_CrossTex5, nUV);
//					fixed4 CR6 = tex2D (_CrossTex6, nUV);
//					
//					emit = CR1;
//									
//					if(c.r > .1)
//						emit = lerp(CR1.rgb,CR2.rgb,(c.r-.1)*10);
//					if(c.r > .2)
//						emit = lerp(CR2.rgb,CR3.rgb,(c.r-.2)*10);
//					if(c.r > .3)
//						emit = lerp(CR3.rgb,CR4.rgb,(c.r-.3)*10);
//					if(c.r > .4)
//						emit = lerp(CR4.rgb,CR5.rgb,(c.r-.4)*10);
//					if(c.r > .5)
//						emit = lerp(CR5.rgb,CR6.rgb,(c.r-.5)*10);
//					if(c.r > .6)
//						emit = lerp(CR6.rgb,float4(1),(c.r-.6)*10);
//					if(c.r > .7)
//						emit = float4(1);
//					
//					emit += _DarkColor*(1-emit);
//////					emit = float3(min(emit.x,_DarkColor.x),emit.y,emit.z);
//					return (emit*_Color,1.0);
//					
//					
////                    return fixed4(1.0);
//                }
//            ENDCG
//        }
    }
    FallBack "VertexLit"    // Use VertexLit's shadow caster/receiver passes.
}
 