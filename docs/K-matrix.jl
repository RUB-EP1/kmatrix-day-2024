### A Pluto.jl notebook ###
# v1.1.0

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 9ade0bbc-0b04-4e6d-92cf-54062b638cfe
md"""
# Practical K-Matrix Applications

This educational material introduces the K-matrix formalism, focusing on its practical application in describing scattering amplitude observables. The K-matrix approach provides a robust framework for analyzing scattering processes, essential for understanding resonance phenomena in hadron physics. One of the main challenges in employing this formalism lies in the initial estimation of the bare parameters, which requires a thorough comprehension of the underlying principles and mechanics of the model.

On the figure below one can find illustration of the ab->cd scattering process with resonance which has mass $m_{0}$ and width $Г_{0}$. This process can be described with K-matrix:

$K_{ij} = \frac{g_i g_j}{m_0^2-s}$

where $g_{i} g_j$ indicates different possible channels of the scattering process and $s=m^{2}$. K-matrix has to be real and symmetric by construction.

Then, one can introduce transition T-matrix:

$T = [I -i  K \rho]^{-1} K$
where $I$ is identity matrix of three dimensions and $\rho$ being a diagonal matrix of phase space factors $\rho=Diag(\rho_i)$.
"""

# ╔═╡ 437d3bf9-cf44-40a8-97bc-8aee4b62d069
RobustLocalResource("",	joinpath("..","figures","1x1_scattering.png"))

# ╔═╡ e8ba4b4e-2d21-4bfe-bf32-02969f9b2970
md"""
The provided examples are designed to facilitate this understanding by illustrating the connection between the K-matrix parameters and observable quantities.


**Exapmle 1 (3x3 one pole):** The connection between the K-matrix and the multichannel Breit-Wigner model, demonstrating the generation of resonance widths.

**Example 2 (2x2 two poles):** The analysis of a 2x2 problem highlighting the dynamics of weakly coupled resonances.

**Example 3 (1x1 two poles):** The examination of a single-channel production amplitude involving two interfering resonances.

These examples provide insights into estimating parameters, understanding resonance behavior, and interpreting observable phenomena within the K-matrix framework.
"""

# ╔═╡ cb9fdca3-db42-4501-a2fe-c3ff099b2d83
TableOfContents()

# ╔═╡ a4750e66-b448-479e-a5dd-b9aec0f3a857
aside(RobustLocalResource("",	joinpath("..","figures","3x3_scattering.png")))

# ╔═╡ c2a0a8bc-c1e6-4a48-91dc-590ca79383ff
md"""
## Example 1: Multichannel Breit-Wigner Model and Resonance Widths

The first example explains the relationship between the K-matrix and the multichannel Breit-Wigner (BW) model. It demonstrates how resonance widths are generated within this framework, offering insight into the dynamic nature of resonances. This example is pivotal for appreciating how the K-matrix formalism can be used to describe complex resonance structures in multichannel scattering processes.
"""

# ╔═╡ 798f53e9-d871-42d1-a81c-d35adc7ece21
md"""
### Setup

Let's consider 3 coupled channels, the scattering amplitude T is a 3x3 matrix:

$T = \begin{pmatrix}
T_{1\to1} & T_{1\to2} & T_{1\to3}\\
T_{2\to1} & T_{2\to2} & T_{2\to3}\\
T_{3\to1} & T_{3\to2} & T_{3\to3}\\
\end{pmatrix}$

We model it with the simplest **one-pole** K-matrix.

$K = \frac{1}{m_0^2-s}
\begin{pmatrix}
g_1^2 & g_1 g_2 & g_1 g_3\\
g_2 g_1 & g_2^2 & g_2 g_3\\
g_3 g_1 & g_3 g_2 & g_3^2\\
\end{pmatrix}$

and $\rho=\text{Diag}(\rho_1,\rho_2,\rho_3)$
"""

# ╔═╡ 1215bc85-4760-473b-93d0-5d6a8952e27e
question_box(md"""
**E1.Q1:** When $K$ is degenerate and has rank 1, the expression for T is simple. Figure it out for 3x3 matrix.

**Advanced option:** Can you prove it for general case?
""")

# ╔═╡ 7b717c8f-1fb8-4892-a250-c77e5e088445
aside(tip(md"$T = [1-iK\rho]^{-1}K$"))

# ╔═╡ 1273bd41-9986-4b9f-9e06-b3bed7ab65f0
answer_box(
md"$T_{ij} = \frac{g_i g_j}{m_0^2-s-ig_1^2 \rho_1-ig_2^2 \rho_2-ig_3^2 \rho_3}$

This is expression known as the [Flatte formula](https://inspirehep.net/literature/108884)
")

# ╔═╡ 6d5acd0c-dbcf-4d0a-a94c-76ac59006fc8
md"""

## Comparison to Breit-Wigner

Let's compare to the BW parametrization

$\text{BW} = \frac{m_0\Gamma_0}{m_0^2-s-im_0 \Gamma_0}$

"""

# ╔═╡ fe35af83-4910-48e4-b9de-5b8a1f85fb72
md"""
Cross section of certain channel calculated as

$\frac{\mathrm{d}\sigma}{\mathrm{d}m} = \frac{1}{J_i} |T_{ij}|^2 \frac{\mathrm{d}\Phi_j}{\mathrm{d}m}$

with
- the flux $J_i$ set to 1, and
- the $\mathrm{d}\Phi_j / \mathrm{d}m = 2m\rho_j$ is a phase space per certain energy, and
- the $\rho_j$ is zero below the threshold of the j channel.
"""

# ╔═╡ 3fde6651-a704-4757-b282-3a7cfcd36f6e
md"""
Let's setup couplings for three channels, that we can adjust:
- g₁ = $(@bind g1_T1 Slider(range(0,4,101), default=1.2, show_value=true)) GeV for the first channel,
- g₂ = $(@bind g2_T1 Slider(range(0,4,101), default=0.5, show_value=true)) GeV for the second channel, and
- g₃ = $(@bind g3_T1 Slider(range(0,4,101), default=1.6, show_value=true)) GeV for the third channel.
- m₀ = $(@bind M Slider(range(0,10,101), default=5.3, show_value=true)) GeV/c² pole of the K-matrix.
"""

# ╔═╡ 0ff7e560-37ca-4016-bc01-741322402679
T1 = let
	# thhree channels
	channels = SVector(
			TwoBodyChannel(1.1, 1.1),
	        TwoBodyChannel(2.2, 2.2),
	        TwoBodyChannel(1.3, 1.3))
	# one bare pole
	MG = [(M, gs=[g1_T1, g2_T1, g3_T1])]
	#
	K = Kmatrix(MG)
	T = Tmatrix(K, channels)
end;

# ╔═╡ 3e76dfec-e83c-46df-8838-b299a7aaa5e3
let
	m0 = T1.K.poles[1].M
	plot(title="Scattering cross section 1 → 1", yaxis=nothing)
	# K-matrix
	plot!(2.6, 8, lab="Tₖ[1,1]") do e
		A = amplitude(T1, e)[1,1]
		phsp = real(ρ(T1.channels[1], e)) * e
		abs2(A) * phsp
	end
	vline!([m0], lab="m₀ (K-matrix pole)")
	# BW
	N_peak = abs2(amplitude(T1, m0+iϵ)[1,1])
	plot!(2.6, 8, lab="BW") do e
		Γ0=sum(Γv_T1)
		A = m0*Γ0/(m0^2-e^2-1im*m0*Γ0)
		phsp = real(ρ(T1.channels[1], e)) * e
		N_peak * abs2(A) * phsp
	end
	vline!(map(T1.channels) do ch
		real(ch.m1+ch.m2)
	end, lab="thresholds", ls=:dash)
end

# ╔═╡ 59ceb096-1cc0-4c69-b56f-476710dd698e
question_box(md"""
**E1.Q2:** Which parameter is needed to be changed in order to see difference between BW and K-matrix formalism?
""")

# ╔═╡ 1410b82a-0017-4ef3-adf8-1f4da66393a4
answer_box(
md" $g_{2}$ and $g_{3}$
")

# ╔═╡ ad74e82b-b2f4-4b8d-99ea-2fe295bb018d
md"""
### Calculation of the width

We can relate the approximate width to coupling using the Breit-Wigner expression, $1/(m_0^2-s-im_0\Gamma_0)$, where $\Gamma_0$ gives the width of the peak.
Hence

```math
\begin{align}
\Gamma_0 = \frac{g_1^2 \rho_1 (m_0) + g_2^2 \rho_2(m_0)+g_3^2 \rho_3(m_0)}{m_0}\\
\end{align}
```
"""

# ╔═╡ ce2c280e-6a55-4766-a0f9-941b448c41c9
begin
	Γv_T1 = map(zip(T1.K.poles[1].gs, T1.channels)) do (g, ch)
		m0 = T1.K.poles[1].M
		Γi = g^2*ρ(ch, m0) / m0
		round(Γi, digits=2)
	end |> real
	Markdown.parse("The sum: $(round(sum(Γv_T1), digits=2)) GeV = $(join(string.(Γv_T1), " + ")*" GeV"), that corresponds to $(join(string.(round.(100*Γv_T1./sum(Γv_T1), digits=1)) .*"%", ", ")), respectively.")
end

# ╔═╡ cf9bf7ac-905f-4112-a7f4-36c536d33918
question_box(md"""
**E1.Q3:** Let's assume that we know cross-section distribution and can measure FWHM of it. How is it possible to estimate K-matrix parameters $g_{i}$?
""")

# ╔═╡ 87fc0818-273b-4d0b-814a-058365ee07a0
answer_box(
md" $g_{i}\approx\sqrt\frac{Г_{0}m_{0}}{\rho_{i}(m_0)}$
")

# ╔═╡ 915f987d-9bb5-4e0b-9cf0-f52e3937695a
md"""
## Example 2: The 2x2 Problem with Weakly Coupled Resonances

In the second example, we explore the 2x2 problem, focusing on scenarios with weakly coupled resonances. This case study sheds light on the interactions between resonances in a two-dimensional parameter space, emphasizing the effects of weak coupling. It is an essential exploration for understanding how resonance coupling influences scattering amplitudes and observable resonance characteristics.
"""

# ╔═╡ 2486eb34-a858-4ea9-99e1-f17627589461
RobustLocalResource("",	joinpath("..","figures","2x2_scattering.png"))

# ╔═╡ a6fd628c-86db-4d3f-836b-ff376cac7f1d
T2 = let
	# two channels
	channels = SVector(
			TwoBodyChannel(1.1, 1.1),
	        TwoBodyChannel(1.3, 1.3))
	# two bare pole
	g1_T2 = 2.1
	h2_T2 = 2.5
	MG = [
		(M=4.3, gs=[g1_T2, g2_T2]),
		(M=6.3, gs=[h1_T2, h2_T2])]
	#
	K = Kmatrix(MG)
	T = Tmatrix(K, channels)
end;

# ╔═╡ 1663348b-ed67-4851-9365-9641e6379fcd
md"""

The K-matrix for such case consists of two terms:

$K =K^{(1)}+K^{(2)}
= \frac{1}{m_{(1)}^2-s}
\begin{pmatrix}
g_1^2 & g_1 g_2\\
g_2 g_1 & g_2^2
\end{pmatrix} +
\frac{1}{m_{(2)}^2-s}
\begin{pmatrix}
h_1^2 & h_1 h_2\\
h_2 h_1 & h_2^2
\end{pmatrix}$
"""

# ╔═╡ 74e06991-79a2-4711-8bc7-c8656249641f
md"""
### The case of not coupled resonances
"""

# ╔═╡ c7e615fa-62aa-4de2-8ef4-2df8534b2c06
question_box(md"""
**E2.Q1:** Let's start with setting off-diagonal parameters described coupling to zeros $g_{2}=h_{1}=0$. Then K-matrix would be What would be

$K =
\begin{pmatrix}
\frac{g_1^2}{m_{(1)}^2-s} & 0\\
0 & \frac{h_2^2}{m_{(2)}^2-s}
\end{pmatrix}$

How will the T-matrix look like?
""")

# ╔═╡ a223cbff-88b0-4a28-af53-c139e7b9108a
tip(md"For single resonance:

$T =
\frac{1}{m_{(1)}^2-s-ig_1^2\rho_1-ig_2^2\rho_2}
\begin{pmatrix}
g_1^2 & g_1g_2\\
g_2g_1 & g_2^2
\end{pmatrix}$

")

# ╔═╡ 9d9a89ed-76f3-4e76-a3cc-0d33c747fbb5
answer_box(md"""
In that case, the T-matrix would be simply:

$T =
\begin{pmatrix}
\frac{g_1^2}{m_{(1)}^2-s-ig_1^2\rho_1} & 0\\
0 & \frac{h_2^2}{m_{(2)}^2-s-ih_2^2\rho_2}
\end{pmatrix}$
""")

# ╔═╡ 729c86ab-cf81-48bf-82be-b89cf28eaee6
md"""

### Demonstration

- g₂ = $(@bind g2_T2 Slider(range(-1,3,81), default=0.0, show_value=true)) GeV for the first channel,
- h₁ = $(@bind h1_T2 Slider(range(-1,3,81), default=0.0, show_value=true)) GeV for the second channel, and
"""

# ╔═╡ fbfc0e6c-775e-4025-ad06-e3f6e291ec52
let
	plot(title=["Scattering cross section" ""], yaxis=nothing,
		layout=grid(2,1, heights=(0.5,0.5)), size=(700,500))
	plot!(2.6, 8, sp=1, lab="Tₖ[1,1]") do e
		A = amplitude(T2, e)[1,1]
		phsp = real(ρ(T2.channels[1], e)) * e
		abs2(A) * phsp
	end
	vline!(sp=1, [T2.K.poles[1].M])
	plot!(2.6, 8, sp=2, lab="Tₖ[2,2]") do e
		A = amplitude(T2, e)[2,2]
		phsp = real(ρ(T2.channels[1], e)) * e
		abs2(A) * phsp
	end
	vline!(sp=2, [T2.K.poles[2].M])
	plot!(2.6, 8, sp=2, lab="Tₖ[1,2]") do e
		A = amplitude(T2, e)[1,2]
		phsp = real(ρ(T2.channels[1], e)) * e
		abs2(A) * phsp
		abs2(A) * phsp
	end
end

# ╔═╡ 0f2ade1e-6958-4ebd-942a-c844bf3dbb99
md"""
### The case of weak coupling for one of the resonances
"""

# ╔═╡ a7a68629-bf6f-435e-9a97-de9a02a31160
question_box(md"""
**E2.Q2:** Let's find the first expansion term to reflect on how a weakly coupled resonances show up in the second channel. For that put $g_2=\epsilon$, $h_1 = 0$.

Then,

$K^{(1)} = \frac{1}{m_{(1)}^2-s}
\begin{pmatrix}
g_1^2 & g_1 \epsilon\\
\epsilon g_1 & \epsilon^2
\end{pmatrix}
\approx \frac{1}{m_{(1)}^2-s}
\begin{pmatrix}
g_1^2 & g_1 \epsilon\\
\epsilon g_1 & 0
\end{pmatrix}$

In this case the T-matrix will become:
""")

# ╔═╡ a1558b96-576f-4661-b357-c9f036c0167d
answer_box(md"""
The T-matrix in that case would be:

$T \approx
\begin{pmatrix}
\frac{g_1^2}{m_{(1)}^2-s-ig_1^2\rho_1} & \frac{g_1\epsilon}{m_{(1)}^2-s-ig_1^2\rho_1}\\
\frac{\epsilon g_1}{m_{(1)}^2-s-ig_1^2\rho_1} & \frac{h_2^2}{m_{(2)}^2-s-ih_2^2\rho_2}
\end{pmatrix}$

One can notice that:

(1) $T^{(0)}_{11}=T^{(\epsilon)}_{11}$ and $T^{(0)}_{22}=T^{(\epsilon)}_{22}$

(2) $\frac{T^{(\epsilon)}_{12}}{T^{(\epsilon)}_{11}}=\frac{\epsilon}{g_{1}}$

(here $T^{(0)}$ and $T^{(\epsilon)}$ indicate previous and this case respectively)

Hence one will see effects of channel couplings only when $g_{2}$ will be in order of $g_{1}$

""")

# ╔═╡ fff6f9f5-b002-46ea-b6ff-1ecf32357ea9
md"""
### The case of weak coupling for both resonances
"""

# ╔═╡ 8b53b1cc-520b-48e4-b2b1-6ad6ebe443e2
question_box(md"""
**E2.Q3:** Let's , finally, put $g_2=h_1=\epsilon$.

What will we see for the off-diagonal terms of T-matrix?

""")

# ╔═╡ 1e7ebcaf-dd83-40fb-9bd8-2e48a1911bfa
answer_box(md"""

$T_{12}=T_{21}=\frac{g_1\epsilon}{m_{(1)}^2-s-ig_1^2\rho_1}+\frac{h_2\epsilon}{m_{(2)}^2-s-ih_2^2\rho_2}=(BW_{g_{1}}+BW_{h_{2}})\epsilon$

""")

# ╔═╡ 0e899f67-adec-4837-9993-c9fe22f788d1
md"""
## Example 3: Single-Channel Production Amplitude with Interfering Resonances

The third example examines a single-channel problem featuring two prominent resonances. The focus is on the production amplitude and the investigation of interference effects between resonances. This scenario is critical for comprehending how overlapping resonances interact within the K-matrix formalism, affecting the overall scattering amplitude and observable patterns in the data.
"""

# ╔═╡ 27f0ae17-b61c-49c5-b4fc-6de5d2ddda94
md"""
### Scattering amplitude
"""

# ╔═╡ babfbc1f-7beb-44d1-b3c8-75309e8b817c
T3 = let
	# one channels
	channels = SVector(
			TwoBodyChannel(1.1, 1.1))
	# two bare pole
	MG = [
		(M=4.3, gs=[2.1]),
		(M=6.3, gs=[2.5])]
	#
	K = Kmatrix(MG)
	T = Tmatrix(K, channels)
end;

# ╔═╡ 8b92df7f-d97b-43fa-8ac3-fed8ee974f5f
md"""
For this case K-matrix will become just a function of s:

$K = \frac{g^2}{m_{(1)}^2-s}+
\frac{h^2}{m_{(2)}^2-s}$

$T = [1-iK\rho ]^{-1} K$

If K is zero for $s=s_\text{z}$, T is zero.
"""

# ╔═╡ 7b4fa73c-1075-4271-8d2f-1668d98904ab
let
	plot(title="Scattering cross section", yaxis=nothing)
	plot!(2.6, 8, lab="Tₖ") do e
		A = amplitude(T3, e)[1,1]
		phsp = real(ρ(T3.channels[1], e)) * e
		abs2(A) * phsp
	end
	vline!([T3.K.poles[1].M, T3.K.poles[2].M])
end

# ╔═╡ edef417d-b0e4-4cad-bf63-462a8d7e861f
question_box(md"""
**E3.Q1:** Why does it have 0?
""")

# ╔═╡ 53ad2e4e-0268-4488-9891-815922d8a8db
aside(tip(md"For explanation let's have a look at K-matrix in these case."))

# ╔═╡ 8556c8f4-89e4-4544-ad73-4da8b43a7051
p = let
	f1(x)=1/(T3.K.poles[1].M-x)
	f2(x)=1/(T3.K.poles[2].M-x)
	f3(x)=f1(x)+f2(x)
	plot(title="K-matrix parameter")
	plot!(rangeclamp(f1), 3, 7, lab="First pole, K1")
	plot!(rangeclamp(f2), 3, 7, lab="Second pole, K2")
	plot!(rangeclamp(f3), 3, 7, lab="Total")
	vline!([T3.K.poles[1].M, T3.K.poles[2].M], linestyle=:dash)
	hline!([0], color=:black, size=(400,300), leg=:top)
end;

# ╔═╡ e9c0d423-793d-4997-a0fd-5c67b41fffb2
answer_box(
TwoColumn(md"There are two poles because of which both K-matrix have asymptotics which interfere and results in 0 between them", plot(p))
)

# ╔═╡ 91db142a-109f-414a-8d2c-9d3cd92bae40
md"""
### Production amplitude

The difference between production and scattering is that now one replace K-matrix with vector:

$A = [1-iK\rho]^{-1}
\begin{pmatrix}
\frac{\alpha_1 g}{m_{(1)}^2-s}\\
\frac{\alpha_2 h}{m_{(2)}^2-s}
\end{pmatrix}$

Where $a_1$ and $a_2$ are production factors which might be complex.
"""

# ╔═╡ 12a615bb-97b8-4fde-bd66-ac7083970e0e
RobustLocalResource("", joinpath("..","figures", "1x1_production.png"), cache=false)

# ╔═╡ f9dad52e-d6a2-46c4-a5b3-91a50c9425c1
md"""
Production couplings
- α₁ = $(@bind α1_E3 Slider(range(0.01,2,61), default=1.0, show_value=true))
- |α₂| = $(@bind α2_E3 Slider(range(-1,2,61), default=1.0, show_value=true))
- Arg(α₂) = $(@bind ϕ2_E3 Slider(range(0,2π,100), default=0.0, show_value=true))
"""

# ╔═╡ ff61d6e1-5681-4d15-8164-62baee4613ba
A_E3 = ProductionAmplitude(T3, SVector{2}(α1_E3, α2_E3*cis(ϕ2_E3)), SVector{1}(0));

# ╔═╡ b90a1c10-8e57-4b2a-b48a-ccb78010a4f5
let
	plot()
	plot!(title="Production cross section", 2.6, 8, sp=1, lab="Total production", yaxis=nothing) do e
		A = amplitude(A_E3, e)[1]
		phsp = real(ρ(T3.channels[1], e)) * e
		abs2(A) * phsp
	end
	map([1,2]) do ind
		plot!(2.6, 8, sp=1, fill=0, alpha=0.2, lab="from R$(ind)") do e
			A = productionpole(A_E3, e, ind)[1]
			phsp = real(ρ(T3.channels[1], e)) * e
			abs2(A) * phsp
		end
	end
	vline!([T3.K.poles[1].M, T3.K.poles[2].M])
	plot!()
end

# ╔═╡ cf9733b3-bdc9-4e58-a7f3-87845eb907da
question_box(md"""
**E3.Q2:** What can the complexity of a production factor lead to?
How the plot above will change?
""")

# ╔═╡ 3019d77e-a41e-4fa5-a0bf-b91d3d72e96f
md"""
## Implementation
"""

# ╔═╡ 2a5d2458-9958-4c9b-a183-d7029b6360c9
# ╠═╡ show_logs = false
begin
	using StaticArrays
	using Plots
	using LaTeXStrings
	using PlutoUI
	using Parameters
	using LinearAlgebra
	using PlutoTeachingTools
	using CalculusWithJulia
end

# ╔═╡ 25758574-5da4-4fbe-946d-d55f6210b7e2
theme(:wong2, frame=:box, grid=false, minorticks=true,
    guidefontvalign=:top, guidefonthalign=:right,
    foreground_color_legend=nothing,
    xlim=(:auto, :auto), ylim=(:auto, :auto),
	lab="", xlab="Mass of system [GeV]")

# ╔═╡ ae68a0e2-46ce-4186-97b3-4b03b5f2d8ce
begin
	struct TwoBodyChannel
	    m1::Complex{Float64}
	    m2::Complex{Float64}
	    L::Int
	end
	TwoBodyChannel(m1, m2; L::Int=0) = TwoBodyChannel(m1, m2, L)
	#
	function ρ(ch::TwoBodyChannel, m; ϕ=-π / 2)
	    ch.L != 0 && error("not implemented")
	    sqrt(cis(ϕ) * (m - (ch.m1 + ch.m2))) * cis(-ϕ / 2) *
	    sqrt(m + (ch.m1 + ch.m2)) *
	    sqrt((m^2 - (ch.m1 - ch.m2)^2)) /
	    m^2
	end
end

# ╔═╡ 0360447c-c6c7-4ba6-8e5f-a20d5797995b
begin
	struct Kmatrix{N,V}
	    poles::SVector{V,NamedTuple{(:M, :gs),Tuple{Float64,SVector{N,Float64}}}}
	    nonpoles::SMatrix{N,N,Float64}
	end
	function Kmatrix(_poles)
		V, N = length(_poles), length(first(_poles).gs)
		poles = map(_poles) do p
			(; M=p.M, gs=SVector{N}(p.gs))
		end |> SVector{V}
		nonpoles = SMatrix{N,N}(fill(0.0, (N,N)))
		return Kmatrix(poles, nonpoles)
	end
	#
	amplitude(K::Kmatrix, m) =
	    sum((gs * gs') ./ (M^2 - m^2) for (M, gs) in K.poles) + K.nonpoles
	#
	npoles(X::Kmatrix{N,V}) where {N,V} = V
	nchannels(X::Kmatrix{N,V}) where {N,V} = N
	#
end

# ╔═╡ 1072afe6-bad7-4de3-9ad2-6dcef2b924bb
begin
	struct Tmatrix{N,V}
	    K::Kmatrix{N,V}
	    channels::SVector{N,TwoBodyChannel}
	end
	#
	function Dmatrix(T::Tmatrix{N,V}, m; ϕ=-π / 2) where {N,V}
	    𝕀 = Matrix(I, (N, N))
	    iρv = 1im .* ρ.(T.channels, m; ϕ) .* 𝕀
	    K = amplitude(T.K, m)
	    D = 𝕀 - K * iρv
	end
	detD(T::Tmatrix, m; ϕ=-π / 2) = det(Dmatrix(T, m; ϕ))
	amplitude(T::Tmatrix, m; ϕ=-π / 2) = inv(Dmatrix(T, m; ϕ)) * amplitude(T.K, m)
	#
	npoles(X::Tmatrix{N,V}) where {N,V} = V
	nchannels(X::Tmatrix{N,V}) where {N,V} = N
	channels(X::Tmatrix) = X.channels
end

# ╔═╡ ebf8b842-99ce-40e8-9bf4-931471879bf9
function productionpole(T::Tmatrix, m, iR::Int; ϕ=-π / 2)
    @unpack M, gs = T.K.poles[iR]
    P = gs ./ (M^2 - m^2)
    return inv(Dmatrix(T, m; ϕ)) * P
end

# ╔═╡ 9a2e8210-c140-4689-bb16-2aab3c3b2aaa
productionnonpole(T::Tmatrix{N,K}, m; ϕ=-π / 2) where {N,K} =
    inv(Dmatrix(T, m; ϕ)) * ones(N)
#

# ╔═╡ fb45f5a8-15c4-4695-b36b-f21aab1e3d80
begin
	struct ProductionAmplitude{N,V}
	    T::Tmatrix{N,V}
	    αpoles::SVector{V,<:Number}
	    αnonpoles::SVector{N,<:Number}
	end
	#
	npoles(X::ProductionAmplitude{N,V}) where {N,V} = V
	nchannels(X::ProductionAmplitude{N,V}) where {N,V} = N
	detD(X::ProductionAmplitude, m; ϕ=-π / 2) = detD(X.T, m; ϕ)
	channels(X::ProductionAmplitude) = channels(X.T)
	#
	ProductionAmplitude(T::Tmatrix{N,V}) where {N,V} =
	    ProductionAmplitude(T, SVector{V}(ones(V)), SVector{N}(ones(N)))
	#
	function amplitude(A::ProductionAmplitude, m; ϕ=-π / 2)
	    @unpack T, αpoles, αnonpoles = A
	    P = αnonpoles
	    for (α, Mgs) in zip(αpoles, A.T.K.poles)
	        @unpack M, gs = Mgs
	        P += α .* gs ./ (M^2 - m^2)
	    end
	    D⁻¹ = inv(Dmatrix(T, m; ϕ))
	    return D⁻¹ * P
	end
end

# ╔═╡ 474e5d19-b537-42d2-9e92-2a26996cee2d
const iϵ = 1e-7im

# ╔═╡ 35b9a451-5fac-46e2-97bb-ebc19d4b3418
function productionpole(A::ProductionAmplitude{N,V}, m, iR::Int; ϕ=-π / 2) where {N,V}
    αnonpoles = SVector{N}(zeros(N))
    αpoles = zeros(Complex{Float64}, V)
    αpoles[iR] = A.αpoles[iR]
    A = ProductionAmplitude(A.T, SVector{V}(αpoles), αnonpoles)
    return amplitude(A, m; ϕ)
end

# ╔═╡ 2aef1bd5-7a81-417b-a090-77644fc5f640
function productionnonpole(A::ProductionAmplitude{N,V}, m; ϕ=-π / 2) where {N,V}
    @unpack T, αnonpoles = A
    αpoles = SVector{V}(zeros(V))
    A = ProductionAmplitude(T, αpoles, αnonpoles)
    return amplitude(A, m; ϕ)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CalculusWithJulia = "a2e0e22d-7d4c-5312-9169-8b992201a882"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Parameters = "d96e819e-fc66-5662-9728-84c9c7592b0a"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[compat]
CalculusWithJulia = "~0.3.3"
LaTeXStrings = "~1.4.1"
Parameters = "~0.13.1"
Plots = "~1.41.7"
PlutoTeachingTools = "~0.5.0"
PlutoUI = "~0.7.84"
StaticArrays = "~1.9.24"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.13.3"
manifest_format = "2.1"
project_hash = "4eece068363d53faf2eef9f78aa4bd48b23b49d2"

[[deps.AbstractPlutoDingetjes]]
git-tree-sha1 = "e71ee7b4aa06b045259a7d6101e1cb45ad140bce"
registries = "General"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.4.1"

[[deps.Accessors]]
deps = ["CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "MacroTools"]
git-tree-sha1 = "8c0bc12397dabf5d2dfc4b5763ec463854cc44d3"
registries = "General"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.46"

    [deps.Accessors.extensions]
    AxisKeysExt = "AxisKeys"
    IntervalSetsExt = "IntervalSets"
    LinearAlgebraExt = "LinearAlgebra"
    StaticArraysExt = "StaticArrays"
    StructArraysExt = "StructArrays"
    TestExt = "Test"
    UnitfulExt = "Unitful"

    [deps.Accessors.weakdeps]
    AxisKeys = "94b1ba4f-4ee9-5380-92f1-94cde586c3c5"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
registries = "General"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
registries = "General"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "0cfb779e24fdced77a05df1dbe99200821a9f563"
registries = "General"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.8+1"

[[deps.CalculusWithJulia]]
deps = ["Base64", "Contour", "ForwardDiff", "IntervalSets", "LinearAlgebra", "PlotUtils", "Printf", "Random", "Reexport", "Roots", "SpecialFunctions", "SplitApplyCombine", "Test"]
git-tree-sha1 = "9a8295857b1d5f1c2e4fa160e37e9e468f7805a3"
registries = "General"
uuid = "a2e0e22d-7d4c-5312-9169-8b992201a882"
version = "0.3.3"

    [deps.CalculusWithJulia.extensions]
    CalculusWithJuliaPlotsExt = "Plots"
    CalculusWithJuliaSymPyCoreExt = "SymPyCore"

    [deps.CalculusWithJulia.weakdeps]
    Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
    SymPyCore = "458b697b-88f0-4a86-b56b-78b75cfb3531"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "060adaf7a5c2e14bca025edf0eea0206ffdebd87"
registries = "General"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.32.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "af523e59de94de05b9b367a2ca4d63233aacd222"
registries = "General"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.5"
weakdeps = ["StyledStrings"]

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "96fce5c80e0834e96ab6d24fb384fd945c9cb2d4"
registries = "General"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.11.2"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Reexport"]
git-tree-sha1 = "0737a3e59f9d94957f5b177fa2ca40901636b85b"
registries = "General"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.4"

[[deps.CommonSolve]]
deps = ["PrecompileTools"]
git-tree-sha1 = "6c389fa857f6ca5a95474b52a52023fd77f24cb7"
registries = "General"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.14"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
registries = "General"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.5.5+2"

[[deps.CompositionsBase]]
git-tree-sha1 = "802bb88cd69dfd1509f6670416bd4434015693ad"
registries = "General"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.2"
weakdeps = ["InverseFunctions"]

    [deps.CompositionsBase.extensions]
    CompositionsBaseInverseFunctionsExt = "InverseFunctions"

[[deps.ConstructionBase]]
git-tree-sha1 = "b1bc10667320dd5367aff450a992c951ea38fbbc"
registries = "General"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.6.1"
weakdeps = ["IntervalSets", "LinearAlgebra", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
registries = "General"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
registries = "General"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["OrderedCollections"]
git-tree-sha1 = "b0bc6d2cad1fed8b7fd59a1551a991cb3d2809e6"
registries = "General"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.19.6"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "473e9afc9cf30814eb67ffa5f2db7df82c3ad9fd"
registries = "General"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.16.2+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
registries = "General"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Dictionaries]]
deps = ["Indexing", "Random", "Serialization"]
git-tree-sha1 = "a55766a9c8f66cf19ffcdbdb1444e249bb4ace33"
registries = "General"
uuid = "85a47980-9c8c-11e8-2b9f-f7ca1fa99fb4"
version = "0.4.6"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
registries = "General"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "7ab8388b721794863a6e809a2436e639832ee74a"
registries = "General"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.17.1"

[[deps.DocStringExtensions]]
git-tree-sha1 = "38ef52f18cbdfa783ec6c25acc23fb1e8525ec16"
registries = "General"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.10.2"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
registries = "General"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f2659a735f9360fedfa29925812380f322679e93"
registries = "General"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.10.0+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "7bd13840b4148949e290748071bbe6826b3eabcd"
registries = "General"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.6"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libva_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d9d3cd382f2c999f684e6bfa4039fcc16c153b6f"
registries = "General"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "9.0.2+0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Random", "Statistics"]
git-tree-sha1 = "59af96b98217c6ef4ae0dfe065ac7c20831d1a84"
registries = "General"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.6"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "e1e9ba3a8f5d71e6ae698f138a1362aeabb42e9f"
registries = "General"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.18.3+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
registries = "General"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "a55669aa77ae8bbdc7310c4027112500ff5ec874"
registries = "General"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "1.4.7"
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d95a7a3a7e0f2fffc6291bd33035830aab01310b"
registries = "General"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.15.0+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e894be022a2eba58463939f1bf1f7f7006f27f52"
registries = "General"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.19+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "64bbbb7d1499297751b536dd39c58b20750ab1db"
registries = "General"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.5.1+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "JSON", "Libdl", "LinearAlgebra", "Preferences", "Printf", "Qt6Wayland_jll", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "p7zip_jll"]
git-tree-sha1 = "4d777f73c46b46b8b5276206059cf8a195499314"
registries = "General"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.73.27"

    [deps.GR.extensions]
    IJuliaExt = "IJulia"

    [deps.GR.weakdeps]
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f8eb8f7ba13ea75083531647fc8faeda8d541f07"
registries = "General"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.73.27+0"

[[deps.GettextRuntime_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll"]
git-tree-sha1 = "45288942190db7c5f760f59c04495064eedf9340"
registries = "General"
uuid = "b0724c58-0f36-5564-988d-3bb0596ebc4a"
version = "0.22.4+0"

[[deps.Ghostscript_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Zlib_jll"]
git-tree-sha1 = "38044a04637976140074d0b0621c1edf0eb531fd"
registries = "General"
uuid = "61579ee1-b43e-5ca0-a5da-69d92c66a64b"
version = "9.55.1+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "GettextRuntime_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "ea9f1fb37ff10597353b56f3ba0ebd525acef6e0"
registries = "General"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.90.1+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "69ffb934a5c5b7e086a0b4fee3427db2556fba6e"
registries = "General"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.16+0"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "59d266e426ab9695f625fe2b6a51c2d3a04f1ecd"
registries = "General"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "100.15001.0+0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
registries = "General"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "d1a86724f81bcd184a38fd284ce183ec067d71a0"
registries = "General"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "1.0.0"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "0ee181ec08df7d7c911901ea38baf16f755114dc"
registries = "General"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "1.0.0"

[[deps.Indexing]]
git-tree-sha1 = "ce1566720fd6b19ff3411404d4b977acd4814f9f"
registries = "General"
uuid = "313cdc1a-70c2-5d6a-ae34-0150d3930a38"
version = "1.1.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IntervalSets]]
git-tree-sha1 = "0db6aea5b64caa1c47e9fdd27394f0296f05e8bf"
registries = "General"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.15"

    [deps.IntervalSets.extensions]
    IntervalSetsMakieExt = "Makie"
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

    [deps.IntervalSets.weakdeps]
    Makie = "ee78f7c6-11fb-53f2-987a-cfe4a2b5a57a"
    Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.InverseFunctions]]
git-tree-sha1 = "5cc6ad3e2bfc75a11eed92632ee341d37f4a4536"
registries = "General"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.18"
weakdeps = ["Dates", "Test"]

    [deps.InverseFunctions.extensions]
    InverseFunctionsDatesExt = "Dates"
    InverseFunctionsTestExt = "Test"

[[deps.IrrationalConstants]]
git-tree-sha1 = "d22e8bdb3f03c300a103ff23c0dd5a654c6701de"
registries = "General"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.7"

[[deps.JLFzf]]
deps = ["REPL", "Random", "fzf_jll"]
git-tree-sha1 = "82f7acdc599b65e0f8ccd270ffa1467c21cb647b"
registries = "General"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.11"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7204148362dafe5fe6a273f855b8ccbe4df8173e"
registries = "General"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.8.0"

[[deps.JSON]]
deps = ["Dates", "Logging", "Parsers", "PrecompileTools", "StructUtils", "UUIDs", "Unicode"]
git-tree-sha1 = "06d90f699285d055e34f0b014636a75a17ff2252"
registries = "General"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "1.13.4"

    [deps.JSON.extensions]
    JSONArrowExt = ["ArrowTypes"]
    JSONSerializationExt = ["Serialization"]

    [deps.JSON.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
    Serialization = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e06b451acfb1c6fa5ea753b5042207226271f455"
registries = "General"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.2.1+0"

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "059aabebaa7c82ccb853dd4a0ee9d17796f7e1bc"
registries = "General"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.3+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6d7c65411dda4bfa0beb7490476122b4f805cf31"
registries = "General"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "4.3.0+0"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e5b100780d4d30d63b4618d7930d48af409c1772"
registries = "General"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "23.1.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f88f3ccef05a6a72a0cf0ed417c8fd68530f4ab2"
registries = "General"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.1"

[[deps.Latexify]]
deps = ["Format", "Ghostscript_jll", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "df7566479bd64f20bd16b09960145e70160ffb3b"
registries = "General"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.12"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"
    TectonicExt = "tectonic_jll"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"
    tectonic_jll = "d7dd28d6-a5e6-559c-9131-7eb760cdacc5"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "1.0.0"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "Zstd_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.22.0+0"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "PCRE2_jll", "Zlib_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.7+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl", "OpenSSL_jll", "Zlib_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.104+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c8da7e6a91781c41a863611c7e966098d783c57a"
registries = "General"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.4.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "d36c21b9e7c172a44a10484125024495e2625ac0"
registries = "General"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.1+1"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
registries = "General"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b8a91037379e1fd661e9b5ff3d7a770424b1f9f2"
registries = "General"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.42.4+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "aebd334d06cee9f24cea70bd19a39749daf73881"
registries = "General"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.7.3+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "9e887184f306b28dbfcff88cefbb0ec80f1aa9e0"
registries = "General"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.42.4+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.13.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "52702dc5aba6392de19d734750c37ffb08515dc0"
registries = "General"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "1.0.5"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
registries = "General"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "1e0228a030642014fe5cfe68c2c0a818f9e3f522"
registries = "General"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.16"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Measures]]
git-tree-sha1 = "b513cedd20d9c914783d8ad83d08120702bf2c77"
registries = "General"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.3"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "d9d20d6eb2a3290ba5c70a1c013b45305cc39c9e"
registries = "General"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2026.10.20"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "676c0f1c1c34224d6869675047a54b42fdc7b8c5"
registries = "General"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.5"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6aa4566bb7ae78498a5e68943863fa8b5231b59"
registries = "General"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.6+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.30+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.7+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.8+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
registries = "General"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e2bb57a313a74b8104064b7efd01406c0a50d2ff"
registries = "General"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.6.1+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "b079a6affebde167dad8ffe0d670b53917fbcb68"
registries = "General"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "2.0.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.47.0+0"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1912a9f1b9ca55005b03ba075f8e19993583e237"
registries = "General"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.58.2+0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "0ed04c372da78ff5b98e35e3bd4f4ca9931299cc"
registries = "General"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.13.1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools"]
git-tree-sha1 = "e5ae52d1f4f19a9591d615cb0f1ef8d415b40933"
registries = "General"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "3.0.6"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "e4a6721aa89e62e5d4217c0b21bd714263779dda"
registries = "General"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.46.4+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "Zstd_jll", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.13.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
registries = "General"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Reexport", "Statistics"]
git-tree-sha1 = "ddcc36fd83fb4cd459a53c891981697bde0d3de6"
registries = "General"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.5.1"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "TOML", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "83bd514e8ff16b5858ac54c53fa0bcf6002a3b00"
registries = "General"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.41.7"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoUI"]
git-tree-sha1 = "5d103af2482cccf2d9737c365a2d53af0597df95"
registries = "General"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.5.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "9869376035f47756b8b8e711fd0d06a06d51da6f"
registries = "General"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.84"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "1e697ad6f68af89cd3651bbe9b4a7b5d800adf5a"
registries = "General"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.4.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "aef1987d90dcc2e2cbd919ad10b2d25bcce4f418"
registries = "General"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.6.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "4fbbafbc6251b883f4d2705356f3641f3652a7fe"
registries = "General"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.4.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "144895f6166994730ee7ff8113b981fc360638f1"
registries = "General"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.10.2+2"

[[deps.Qt6Declarative_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6ShaderTools_jll", "Qt6Svg_jll"]
git-tree-sha1 = "159d253ab126d5b29230cf53521899bea4ef4648"
registries = "General"
uuid = "629bc702-f1f5-5709-abd5-49b8460ea067"
version = "6.10.2+2"

[[deps.Qt6ShaderTools_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "4d85eedf69d875982c46643f6b4f66919d7e157b"
registries = "General"
uuid = "ce943373-25bb-56aa-8eca-768745ed7b5a"
version = "6.10.2+1"

[[deps.Qt6Svg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll"]
git-tree-sha1 = "81587ff5ff25a4e1115ce191e36285ede0334c9d"
registries = "General"
uuid = "6de9746b-f93d-5813-b365-ba18ad4a9cf3"
version = "6.10.2+0"

[[deps.Qt6Wayland_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Qt6Base_jll", "Qt6Declarative_jll"]
git-tree-sha1 = "672c938b4b4e3e0169a07a5f227029d4905456f2"
registries = "General"
uuid = "e99dba38-086e-5de3-a5b1-6e4c66e897c3"
version = "6.10.2+1"

[[deps.REPL]]
deps = ["Base64", "Dates", "FileWatching", "InteractiveUtils", "JuliaSyntaxHighlighting", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "0c0dcffc464cda2ff33fc8ffc1dd1bdd53cd98be"
registries = "General"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.4.0"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
registries = "General"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
registries = "General"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
registries = "General"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
registries = "General"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Roots]]
deps = ["Accessors", "CommonSolve", "Printf"]
git-tree-sha1 = "15f266d7b3039ca0608d2c53bb32225b96932310"
registries = "General"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "3.0.14"

    [deps.Roots.extensions]
    RootsChainRulesCoreExt = "ChainRulesCore"
    RootsForwardDiffExt = "ForwardDiff"
    RootsIntervalRootFindingExt = "IntervalRootFinding"
    RootsSymPyExt = "SymPy"
    RootsSymPyPythonCallExt = "SymPyPythonCall"
    RootsUnitfulExt = "Unitful"

    [deps.Roots.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    IntervalRootFinding = "d2bf35a9-74e0-55ec-b149-d360ff49b807"
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
    SymPyPythonCall = "bc8888f7-b21e-4b7c-a06a-5d9c9496438c"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "1.0.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "9b81b8393e50b7d4e6d0a9f14e192294d3b7c109"
registries = "General"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.3.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Showoff]]
deps = ["Dates"]
git-tree-sha1 = "8238217340ad0aaabe11afe39c1098b5bc9f4c8e"
registries = "General"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.1.1"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "13cd91cc9be159e3f4d95b857fa2aa383b53772a"
registries = "General"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.3"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.13.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "d1a08b3cb5d1470a2b6dc98ba644f1436d5a740f"
registries = "General"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.9.2"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.SplitApplyCombine]]
deps = ["Dictionaries", "Indexing"]
git-tree-sha1 = "55db78e829cf726162fc4fc1b30d05f92092f3f6"
registries = "General"
uuid = "03a91e81-4c3e-53e1-a0a4-9c0c8f19dd66"
version = "1.3.0"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "8a8a52f887f38d44014e24ee46b8a7311c625f6d"
registries = "General"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.24"

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

    [deps.StaticArrays.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StaticArraysCore]]
git-tree-sha1 = "bf7e2d0d9ed9ac2a652fd598c0f784910cc759f2"
registries = "General"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.5"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "e2b53ce13a53367e96601081e33d34746b571bad"
registries = "General"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.5"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "178ed29fd5b2a2cfc3bd31c13375ae925623ff36"
registries = "General"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.8.0"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "IrrationalConstants", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "adb9da019510162e67a4493fc235c23203d8b09e"
registries = "General"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.13"

[[deps.StructUtils]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "d9cfc07e1d1a8985aa9d03870d642b5d7ab2cf33"
registries = "General"
uuid = "ec057cc2-7a8d-4b58-b3b3-92acb9f63b42"
version = "2.12.1"

    [deps.StructUtils.extensions]
    StructUtilsDBInterfaceExt = ["DBInterface", "Tables"]
    StructUtilsDataFramesExt = ["DataFrames"]
    StructUtilsLazilyInitializedFieldsExt = ["LazilyInitializedFields"]
    StructUtilsMeasurementsExt = ["Measurements"]
    StructUtilsStaticArraysCoreExt = ["StaticArraysCore"]
    StructUtilsTablesExt = ["Tables"]

    [deps.StructUtils.weakdeps]
    DBInterface = "a10d1c49-ce27-4219-8d33-6db1a4562965"
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    LazilyInitializedFields = "0e77f7df-68c5-4e49-93ce-4cd80f5598bf"
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tables = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.10.1+0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
registries = "General"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "311349fd1c93a31f783f977a71e8b062a57d4101"
registries = "General"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.13"

[[deps.URIs]]
deps = ["Serialization"]
git-tree-sha1 = "eb3b85ca904a1d1647b15acc091b113b8874b648"
registries = "General"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.7.3"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
registries = "General"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
registries = "General"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
registries = "General"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
registries = "General"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "96478df35bbc2f3e1e791bc7a3d0eeee559e60e9"
registries = "General"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.24.0+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e52eca002a11c30a858185efdfb15311e1c7a6bf"
registries = "General"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.8.4+0"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a3ea76ee3f4facd7a64684f9af25310825ee3668"
registries = "General"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.2+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "9c7ad99c629a44f81e7799eb05ec2746abb5d588"
registries = "General"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.6+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "ce91b54a5f90c4f27df6950706234b34e49cf79e"
registries = "General"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.14+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "aa1261ebbac3ccc8d16558ae6799524c450ed16b"
registries = "General"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.13+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c74ca84bbabc18c4547014765d194ff0b4dc9da"
registries = "General"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.4+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "52858d64353db33a56e13c341d7bf44cd0d7b309"
registries = "General"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.6+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "1a4a26870bf1e5d26cd585e38038d399d7e65706"
registries = "General"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.8+0"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "75e00946e43621e09d431d9b95818ee751e6b2ef"
registries = "General"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.2+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "704274ca960c42049fd9bda089fc4be32af5cdca"
registries = "General"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.5+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "0ba01bc7396896a4ace8aab67db31403c71628f4"
registries = "General"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.7+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "6c174ef70c96c76f4c3f4d3cfbe09d018bcd1b53"
registries = "General"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.6+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a54cf54677c9f6eac0d97e9d757c233b56bc21b9"
registries = "General"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.13+0"

[[deps.Xorg_libpciaccess_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "58972370b81423fc546c56a60ed1a009450177c3"
registries = "General"
uuid = "a65dc6b1-eb27-53a1-bb3e-dea574b5389e"
version = "0.19.0+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXau_jll", "Xorg_libXdmcp_jll"]
git-tree-sha1 = "bfcaf7ec088eaba362093393fe11aa141fa15422"
registries = "General"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.1+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "ed756a03e95fff88d8f738ebc2849431bdd4fd1a"
registries = "General"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.2.0+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "9750dc53819eba4e9a20be42349a6d3b86c7cdf8"
registries = "General"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.6+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f4fc02e384b74418679983a97385644b67e1263b"
registries = "General"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll"]
git-tree-sha1 = "68da27247e7d8d8dafd1fcf0c3654ad6506f5f97"
registries = "General"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "44ec54b0e2acd408b0fb361e1e9244c60c9c3dd4"
registries = "General"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.1+0"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "5b0263b6d080716a02544c55fdff2c8d7f9a16a0"
registries = "General"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.10+0"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_jll"]
git-tree-sha1 = "f233c83cad1fa0e70b7771e0e21b061a116f2763"
registries = "General"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.2+0"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "9a5e6e8f1a7c40941465c04840145e527f0d6b4b"
registries = "General"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.5.0+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "df77b22eb77051b3d0ef30aab979684f7482c66f"
registries = "General"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.48.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a63799ff68005991f9d9491b6e95bd3478d783cb"
registries = "General"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.6.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.3.2+0"

[[deps.Zstd_jll]]
deps = ["CompilerSupportLibraries_jll", "Libdl"]
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c3b0e6196d50eab0c5ed34021aaa0bb463489510"
registries = "General"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.14+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b6a34e0e0960190ac2a4363a1bd003504772d631"
registries = "General"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.61.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "21e05cef1411bfe6b22a1ca8cbdc64a297d4b447"
registries = "General"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.15.3+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "cb007192783c56d8249db4cf0e3495001edfe414"
registries = "General"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.17.5+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
registries = "General"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libdrm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libpciaccess_jll"]
git-tree-sha1 = "28e57478e8a160d346a19c28b3fffb9273bcc9c2"
registries = "General"
uuid = "8e53e030-5e6c-5a89-a30b-be5b7263a166"
version = "2.4.134+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56d643b57b188d30cccc25e331d416d3d358e557"
registries = "General"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.13.4+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "646634dd19587a56ee2f1199563ec056c5f228df"
registries = "General"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.4+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "91d05d7f4a9f67205bd6cf395e488009fe85b499"
registries = "General"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.28.1+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "1fcd6cf05d23adab0b5ffc496d020537215751dc"
registries = "General"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.59+1"

[[deps.libva_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll", "Xorg_libXfixes_jll", "libdrm_jll"]
git-tree-sha1 = "21cbc8fc2ac0bb182ed461e556d9c062ae6a3164"
registries = "General"
uuid = "9a156e7d-b971-5f62-b2c9-67348b8fb97c"
version = "2.24.1+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll"]
git-tree-sha1 = "11e1772e7f3cc987e9d3de991dd4f6b2602663a5"
registries = "General"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.8+0"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "b4d631fd51f2e9cdd93724ae25b2efc198b059b1"
registries = "General"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.7+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.70.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.8.3+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "14cc7083fc6dff3cc44f2bc435ee96d06ed79aa7"
registries = "General"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "10164.0.1+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e7b67590c14d487e734dcb925924c5dc43ec85f3"
registries = "General"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "4.1.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "a1fc6507a40bf504527d0d4067d718f8e179b2b8"
registries = "General"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.13.0+0"

[registries.General]
url = "https://github.com/JuliaRegistries/General.git"
uuid = "23338594-aafe-5451-b93e-139f81909106"
"""

# ╔═╡ Cell order:
# ╟─9ade0bbc-0b04-4e6d-92cf-54062b638cfe
# ╟─437d3bf9-cf44-40a8-97bc-8aee4b62d069
# ╟─e8ba4b4e-2d21-4bfe-bf32-02969f9b2970
# ╠═cb9fdca3-db42-4501-a2fe-c3ff099b2d83
# ╟─a4750e66-b448-479e-a5dd-b9aec0f3a857
# ╟─c2a0a8bc-c1e6-4a48-91dc-590ca79383ff
# ╟─798f53e9-d871-42d1-a81c-d35adc7ece21
# ╟─1215bc85-4760-473b-93d0-5d6a8952e27e
# ╟─7b717c8f-1fb8-4892-a250-c77e5e088445
# ╟─1273bd41-9986-4b9f-9e06-b3bed7ab65f0
# ╟─6d5acd0c-dbcf-4d0a-a94c-76ac59006fc8
# ╟─fe35af83-4910-48e4-b9de-5b8a1f85fb72
# ╟─3fde6651-a704-4757-b282-3a7cfcd36f6e
# ╠═0ff7e560-37ca-4016-bc01-741322402679
# ╟─3e76dfec-e83c-46df-8838-b299a7aaa5e3
# ╟─59ceb096-1cc0-4c69-b56f-476710dd698e
# ╟─1410b82a-0017-4ef3-adf8-1f4da66393a4
# ╟─ad74e82b-b2f4-4b8d-99ea-2fe295bb018d
# ╟─ce2c280e-6a55-4766-a0f9-941b448c41c9
# ╟─cf9bf7ac-905f-4112-a7f4-36c536d33918
# ╟─87fc0818-273b-4d0b-814a-058365ee07a0
# ╟─915f987d-9bb5-4e0b-9cf0-f52e3937695a
# ╟─2486eb34-a858-4ea9-99e1-f17627589461
# ╠═a6fd628c-86db-4d3f-836b-ff376cac7f1d
# ╟─1663348b-ed67-4851-9365-9641e6379fcd
# ╟─74e06991-79a2-4711-8bc7-c8656249641f
# ╟─c7e615fa-62aa-4de2-8ef4-2df8534b2c06
# ╟─a223cbff-88b0-4a28-af53-c139e7b9108a
# ╟─9d9a89ed-76f3-4e76-a3cc-0d33c747fbb5
# ╟─729c86ab-cf81-48bf-82be-b89cf28eaee6
# ╟─fbfc0e6c-775e-4025-ad06-e3f6e291ec52
# ╟─0f2ade1e-6958-4ebd-942a-c844bf3dbb99
# ╟─a7a68629-bf6f-435e-9a97-de9a02a31160
# ╟─a1558b96-576f-4661-b357-c9f036c0167d
# ╟─fff6f9f5-b002-46ea-b6ff-1ecf32357ea9
# ╟─8b53b1cc-520b-48e4-b2b1-6ad6ebe443e2
# ╟─1e7ebcaf-dd83-40fb-9bd8-2e48a1911bfa
# ╟─0e899f67-adec-4837-9993-c9fe22f788d1
# ╟─27f0ae17-b61c-49c5-b4fc-6de5d2ddda94
# ╠═babfbc1f-7beb-44d1-b3c8-75309e8b817c
# ╠═8b92df7f-d97b-43fa-8ac3-fed8ee974f5f
# ╟─7b4fa73c-1075-4271-8d2f-1668d98904ab
# ╟─edef417d-b0e4-4cad-bf63-462a8d7e861f
# ╟─53ad2e4e-0268-4488-9891-815922d8a8db
# ╟─8556c8f4-89e4-4544-ad73-4da8b43a7051
# ╟─e9c0d423-793d-4997-a0fd-5c67b41fffb2
# ╟─91db142a-109f-414a-8d2c-9d3cd92bae40
# ╟─12a615bb-97b8-4fde-bd66-ac7083970e0e
# ╟─f9dad52e-d6a2-46c4-a5b3-91a50c9425c1
# ╟─ff61d6e1-5681-4d15-8164-62baee4613ba
# ╟─b90a1c10-8e57-4b2a-b48a-ccb78010a4f5
# ╟─cf9733b3-bdc9-4e58-a7f3-87845eb907da
# ╟─3019d77e-a41e-4fa5-a0bf-b91d3d72e96f
# ╠═2a5d2458-9958-4c9b-a183-d7029b6360c9
# ╠═25758574-5da4-4fbe-946d-d55f6210b7e2
# ╠═ae68a0e2-46ce-4186-97b3-4b03b5f2d8ce
# ╠═0360447c-c6c7-4ba6-8e5f-a20d5797995b
# ╠═1072afe6-bad7-4de3-9ad2-6dcef2b924bb
# ╠═ebf8b842-99ce-40e8-9bf4-931471879bf9
# ╠═9a2e8210-c140-4689-bb16-2aab3c3b2aaa
# ╠═fb45f5a8-15c4-4695-b36b-f21aab1e3d80
# ╟─474e5d19-b537-42d2-9e92-2a26996cee2d
# ╠═35b9a451-5fac-46e2-97bb-ebc19d4b3418
# ╠═2aef1bd5-7a81-417b-a090-77644fc5f640
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
