<?php if ($teste) { ?>
<div class="warning"><?php echo $text_teste; ?></div>
<?php } ?>
<?php
$order_info  = $this->model_checkout_order->getOrder($this->session->data['order_id']);
$valor_total = number_format($order_info['total'],2);
$valor_total = str_replace(".","",$valor_total);
?>
<div class="checkout-heading"><?php echo $text_barra; ?> </div>
<form method="post" action="index.php?route=payment/cielo/processar" >
	<center>
	<table border="0" style="width:700px>
		<tr>
			<td>
				<div style="width:700px;text-align:center">
				<?php if ($this->config->get('entry_cartao_visae') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<!--Constante HTTP_IMAGE foi removida do OC à tempos, substituido por 'image'-->
					<img src="image/cielo/visa_electron.jpg" /><br />
					<input onchange="javascript:fm_pagamento(this.value,'<?php echo $this->config->get('cielo_visae_parcelas');?>','D');" type="radio" id="bandeira" name="bandeira" value="visa" />
				</div>
				<?php }?>
				<?php if ($this->config->get('cielo_cartao_visa') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="image/cielo/visa.jpg" /><br />
					<input onchange="javascript:fm_pagamento(this.value,'<?php echo $this->config->get('cielo_visa_parcelas');?>','C');" type="radio" id="bandeira" name="bandeira" value="visa" />
				</div>
				<?php }?>
				<?php if ($this->config->get('cielo_cartao_mastercard') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="image/cielo/mastercard.jpg" /><br />
					<input onchange="javascript:fm_pagamento(this.value,'<?php echo $this->config->get('cielo_mastercard_parcelas','C');?>');" type="radio" id="bandeira" name="bandeira" value="mastercard" />
				</div>
				<?php }?>
				<?php if ($this->config->get('cielo_cartao_diners') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="image/cielo/diners.jpg" /><br />
					<input onchange="javascript:fm_pagamento(this.value,'<?php echo $this->config->get('cielo_diners_parcelas');?>','C');" type="radio" id="bandeira" name="bandeira" value="diners" />
				</div>
				<?php }?>
				<?php if ($this->config->get('cielo_cartao_discover') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="image/cielo/discover.jpg" /><br />
					<input onchange="javascript:fm_pagamento(this.value,'<?php echo $this->config->get('cielo_discover_parcelas');?>','C');" type="radio" id="bandeira" name="bandeira" value="discover" />
				</div>
				<?php }?>
				<?php if ($this->config->get('cielo_cartao_elo') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="image/cielo/elo.jpg" /><br />
					<input onchange="javascript:fm_pagamento(this.value,'<?php echo $this->config->get('cielo_elo_parcelas');?>','C');" type="radio" id="bandeira" name="bandeira" value="elo" />
				</div>
				<?php }?>
				<?php if ($this->config->get('cielo_cartao_amex') == 1) { ?>
				<div style="width:90px;height:80px;text-align:center;display:inline-table">
					<img src="image/cielo/amex.jpg" /><br />
					<input onchange="javascript:fm_pagamento(this.value,'<?php echo $this->config->get('cielo_amex_parcelas');?>','C');" type="radio" id="bandeira" name="bandeira" value="amex" />
				</div>
				<?php }?>
				</div>
				<br><br>
			</td>
		</tr>
		<tr>
			<td id="parcelas"><td>
		</tr>
		<tr>
			<?php if ($this->config->get('cielo_webserv') == 1) { ?>
				<table border="0">
					<tr>
						<td colspan="2">
							<h4><strong>Dados do cartão</strong></h4>
						</td>
					</tr>
					<tr>
						<td>Número</td>
						<td><input type="text" name="cartaoNumero" value="4551870000000183"></td>
					</tr>
					<tr>
						<td>Validade (jun/2010 = 201006)</td>
						<td><input type="text" name="cartaoValidade" value="201508"></td>
					</tr>
					<tr>
						<td>Cód. Segurança</td>
						<td><input type="text" name="cartaoCodigoSeguranca" value="973"></td>
					</tr>												
				</table>
			<?php }?>
		</tr>
	</table>
	</center>
	<br /><br />
	<input type="hidden" name="valor_total" value="<?php echo $valor_total;?>" />
	<input type="hidden" name="pedido" value="<?php echo $this->session->data['order_id'];?>" />
	<div class="buttons">
		<div class="right">
		 <input id="button-confirm" type="submit" value="<?php echo $text_pagamento; ?>" class="button" />
		</div>
	</div>
</form>
<p style="text-align:center"><?php echo $text_info; ?></p>
<script type="text/javascript">
function fm_pagamento(bandeira,parcelas,operacao) {
	$.ajax({
		url: 'index.php?route=payment/cielo/parcelamento&bandeira='+bandeira+'&parcelas='+parcelas+'&operacao='+operacao,
		type: 'GET',
		cache: false,
		dataType: 'html',
		success: function(data) {$('#parcelas').html(data);}
	});
}
</script>
